#!/usr/bin/env python3
"""
Foundational Router with Sharding Awareness

Now includes basic sharding-related awareness through GPU count and model size.
Can be used together with sharding helper tools.
"""

import re
import json
import argparse
from typing import List, Dict, Optional, Any


def parse_endpoints(file_path: str = "endpoints/endpoints.txt") -> List[Dict[str, Any]]:
    backends: List[Dict[str, Any]] = []
    try:
        with open(file_path, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                parts = line.split('#', 1)
                url = parts[0].strip()
                comment = parts[1].strip() if len(parts) > 1 else ""

                backend: Dict[str, Any] = {
                    'url': url,
                    'provider': 'unknown',
                    'name': url,
                    'cost': 999.0,
                    'gpus': 1,
                    'model': 'any',
                    'raw_comment': comment
                }

                for match in re.finditer(r'(\w+)=([^,\s]+)', comment):
                    key, value = match.groups()
                    if key == 'cost':
                        try: backend['cost'] = float(value)
                        except: pass
                    elif key == 'gpus':
                        try: backend['gpus'] = int(value.replace('x', ''))
                        except: pass
                    else:
                        backend[key] = value
                backends.append(backend)
    except FileNotFoundError:
        pass
    return backends


def filter_backends(backends, provider=None, min_gpus=None):
    result = backends
    if provider: result = [b for b in result if b.get('provider') == provider]
    if min_gpus: result = [b for b in result if b.get('gpus', 0) >= min_gpus]
    return result


def select_with_fallback(backends, strategy="balanced", model_size=None, preferred_provider=None):
    if not backends: return None
    if preferred_provider:
        preferred = filter_backends(backends, provider=preferred_provider)
        if preferred: return select_backend(preferred, strategy, model_size)
    if model_size == "large":
        large = filter_backends(backends, min_gpus=2)
        if large: return select_backend(large, strategy)
    return select_backend(backends, strategy)


def select_backend(backends, strategy="balanced", model_size=None):
    if not backends: return None
    if strategy == "cheapest":
        return min(backends, key=lambda x: x.get('cost', 999))
    elif strategy == "local":
        local = [b for b in backends if b.get('provider') == 'local']
        return local[0] if local else backends[0]
    else:
        return min(backends, key=lambda x: (x.get('cost', 999), -x.get('gpus', 1)))


def get_recommended_backend(strategy="balanced", model_size=None, preferred_provider=None):
    backends = parse_endpoints()
    return select_with_fallback(backends, strategy, model_size, preferred_provider)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action='store_true')
    parser.add_argument('--json', action='store_true')
    parser.add_argument('--best-for', default='balanced', choices=['cheapest','local','balanced'])
    parser.add_argument('--model-size', choices=['small','large'])
    parser.add_argument('--provider')
    args = parser.parse_args()

    backends = parse_endpoints()

    if args.list:
        if args.json:
            print(json.dumps(backends, indent=2))
        else:
            for b in backends:
                print(f"{b['url']} | {b.get('provider')} cost={b.get('cost')} gpus={b.get('gpus')}")
    else:
        best = select_with_fallback(backends, args.best_for, args.model_size, args.provider)
        if best:
            if args.json:
                print(json.dumps(best, indent=2))
            else:
                print(f"Selected: {best['url']}")
                print(f"  provider={best.get('provider')} cost={best.get('cost')} gpus={best.get('gpus')}")
        else:
            print("No backend available.")

if __name__ == "__main__":
    main()