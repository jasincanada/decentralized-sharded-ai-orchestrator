#!/usr/bin/env python3
"""
Enhanced Model-Aware Router for decentralized-sharded-ai-orchestrator

Improved version with better metadata handling, model-size awareness,
fallback support, and JSON output for integration.

This builds on the initial design from Task #8.
"""

import re
import json
import argparse
from typing import List, Dict, Optional


def parse_endpoints(file_path: str = "endpoints/endpoints.txt") -> List[Dict]:
    """Parse endpoints.txt with rich metadata support."""
    backends = []
    try:
        with open(file_path, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('#'):
                    continue

                parts = line.split('#', 1)
                url = parts[0].strip()
                comment = parts[1].strip() if len(parts) > 1 else ""

                backend = {
                    'url': url,
                    'raw_comment': comment,
                    'provider': 'unknown',
                    'name': url,
                    'cost': 999.0,
                    'gpus': 1,
                    'model': 'unknown'
                }

                # Parse key=value pairs
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


def list_backends(backends: List[Dict], json_output: bool = False):
    if json_output:
        print(json.dumps(backends, indent=2))
        return

    print("Available backends:")
    for b in backends:
        print(f"  {b['url']}")
        print(f"    provider={b.get('provider')} | cost={b.get('cost')} | gpus={b.get('gpus')} | model={b.get('model')}")


def select_best_backend(
    backends: List[Dict],
    preference: str = "default",
    model_size: Optional[str] = None
) -> Optional[Dict]:
    """Select best backend with improved logic."""
    if not backends:
        return None

    filtered = backends[:]

    # Basic model size awareness
    if model_size == "large":
        filtered = [b for b in filtered if b.get('gpus', 1) >= 2]
        if not filtered:
            filtered = backends[:]  # fallback

    if preference == "cheapest":
        return min(filtered, key=lambda x: x.get('cost', 999))
    elif preference == "local":
        local_nodes = [b for b in filtered if b.get('provider') == 'local']
        return local_nodes[0] if local_nodes else filtered[0]
    elif preference == "balanced":
        # Prefer lower cost but with decent GPU count
        return min(filtered, key=lambda x: (x.get('cost', 999), -x.get('gpus', 1)))
    else:
        return filtered[0]


def main():
    parser = argparse.ArgumentParser(description="Enhanced backend router")
    parser.add_argument('--list', action='store_true', help='List all backends')
    parser.add_argument('--json', action='store_true', help='Output in JSON')
    parser.add_argument('--best-for', type=str, default='default',
                        choices=['default', 'cheapest', 'local', 'balanced'],
                        help='Selection strategy')
    parser.add_argument('--model-size', type=str, choices=['small', 'large'],
                        help='Hint for model size (affects GPU requirements)')
    args = parser.parse_args()

    backends = parse_endpoints()

    if args.list:
        list_backends(backends, args.json)
    else:
        best = select_best_backend(backends, args.best_for, args.model_size)
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