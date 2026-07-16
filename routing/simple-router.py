#!/usr/bin/env python3
"""
Advanced Foundational Router

This version includes more advanced strategies and is structured for future service mode.

Capabilities:
- Multiple intelligent strategies (cheapest, balanced, cost_aware, smart)
- Multi-criteria scoring
- Model size & sharding awareness
- Provider preference + fallback chains
- JSON output
- Prepared for service mode (FastAPI / HTTP)

This is the core intelligence layer of the orchestrator.
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


def score_backend(backend: Dict, weights: Dict = None) -> float:
    """Simple multi-criteria scoring. Lower is better."""
    if weights is None:
        weights = {'cost': 1.0, 'gpus': -0.5}  # Prefer lower cost, higher GPUs

    score = 0.0
    score += backend.get('cost', 999) * weights.get('cost', 1.0)
    score += -backend.get('gpus', 1) * weights.get('gpus', 0.5)  # negative because higher GPUs is better
    return score


def select_backend_advanced(backends, strategy="smart", model_size=None, preferred_provider=None):
    if not backends:
        return None

    candidates = backends[:]

    if preferred_provider:
        preferred = [b for b in candidates if b.get('provider') == preferred_provider]
        if preferred:
            candidates = preferred

    if model_size == "large":
        large = [b for b in candidates if b.get('gpus', 1) >= 2]
        if large:
            candidates = large

    if strategy == "cheapest":
        return min(candidates, key=lambda x: x.get('cost', 999))
    elif strategy == "cost_aware":
        return min(candidates, key=lambda x: score_backend(x))
    elif strategy == "smart":
        # Weighted scoring with preference for capability
        return min(candidates, key=lambda x: score_backend(x, {'cost': 1.0, 'gpus': -1.0}))
    else:
        return min(candidates, key=lambda x: (x.get('cost', 999), -x.get('gpus', 1)))


def select_with_fallback(backends, strategy="smart", model_size=None, preferred_provider=None):
    if not backends: return None

    if preferred_provider:
        preferred = [b for b in backends if b.get('provider') == preferred_provider]
        if preferred:
            return select_backend_advanced(preferred, strategy, model_size)

    if model_size == "large":
        large = [b for b in backends if b.get('gpus', 1) >= 2]
        if large:
            return select_backend_advanced(large, strategy)

    return select_backend_advanced(backends, strategy)


def get_recommended_backend(strategy="smart", model_size=None, preferred_provider=None):
    backends = parse_endpoints()
    return select_with_fallback(backends, strategy, model_size, preferred_provider)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action='store_true')
    parser.add_argument('--json', action='store_true')
    parser.add_argument('--best-for', default='smart', choices=['cheapest', 'cost_aware', 'smart'])
    parser.add_argument('--model-size', choices=['small', 'large'])
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