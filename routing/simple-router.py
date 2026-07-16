#!/usr/bin/env python3
"""
Foundational Model-Aware Router

This is the core routing component for the decentralized-sharded-ai-orchestrator.
It is designed to be extensible and integrate with the provider system.

Features:
- Rich metadata parsing
- Multiple selection strategies
- Model size awareness
- Provider-aware selection
- Fallback chain support
- JSON output for integration

This forms part of the foundational intelligence layer.
"""

import re
import json
import argparse
from typing import List, Dict, Optional, Any


def parse_endpoints(file_path: str = "endpoints/endpoints.txt") -> List[Dict[str, Any]]:
    """Parse endpoints.txt into rich backend objects."""
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
                        try:
                            backend['cost'] = float(value)
                        except ValueError:
                            pass
                    elif key == 'gpus':
                        try:
                            backend['gpus'] = int(value.replace('x', ''))
                        except ValueError:
                            pass
                    else:
                        backend[key] = value

                backends.append(backend)
    except FileNotFoundError:
        print(f"Warning: {file_path} not found")
    return backends


def filter_by_provider(backends: List[Dict], provider: str) -> List[Dict]:
    return [b for b in backends if b.get('provider') == provider]


def select_backend(
    backends: List[Dict],
    strategy: str = "balanced",
    model_size: Optional[str] = None,
    preferred_provider: Optional[str] = None,
    fallback: bool = True
) -> Optional[Dict]:
    """Core selection logic with fallback support."""
    if not backends:
        return None

    candidates = backends[:]

    # Provider preference
    if preferred_provider:
        provider_nodes = filter_by_provider(candidates, preferred_provider)
        if provider_nodes:
            candidates = provider_nodes
        elif not fallback:
            return None

    # Model size awareness
    if model_size == "large":
        large_nodes = [b for b in candidates if b.get('gpus', 1) >= 2]
        if large_nodes:
            candidates = large_nodes

    if strategy == "cheapest":
        return min(candidates, key=lambda x: x.get('cost', 999))
    elif strategy == "local":
        local = [b for b in candidates if b.get('provider') == 'local']
        return local[0] if local else candidates[0]
    elif strategy == "balanced":
        return min(candidates, key=lambda x: (x.get('cost', 999), -x.get('gpus', 1)))
    else:
        return candidates[0]


def get_best_backend(
    strategy: str = "balanced",
    model_size: Optional[str] = None,
    preferred_provider: Optional[str] = None
) -> Optional[Dict]:
    """High-level convenience function."""
    backends = parse_endpoints()
    return select_backend(backends, strategy, model_size, preferred_provider)


def main():
    parser = argparse.ArgumentParser(description="Foundational Router")
    parser.add_argument('--list', action='store_true')
    parser.add_argument('--json', action='store_true')
    parser.add_argument('--best-for', default='balanced', choices=['cheapest', 'local', 'balanced'])
    parser.add_argument('--model-size', choices=['small', 'large'])
    parser.add_argument('--provider', help='Prefer specific provider (e.g. aioz, local)')
    args = parser.parse_args()

    backends = parse_endpoints()

    if args.list:
        if args.json:
            print(json.dumps(backends, indent=2))
        else:
            for b in backends:
                print(f"{b['url']} | {b.get('provider')} | cost={b.get('cost')} | gpus={b.get('gpus')}")
    else:
        best = select_backend(backends, args.best_for, args.model_size, args.provider)
        if best:
            if args.json:
                print(json.dumps(best, indent=2))
            else:
                print(f"Selected: {best['url']}")
                print(f"  provider={best.get('provider')} cost={best.get('cost')} gpus={best.get('gpus')}")
        else:
            print("No suitable backend found.")


if __name__ == "__main__":
    main()