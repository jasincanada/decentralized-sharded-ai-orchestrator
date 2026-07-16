#!/usr/bin/env python3
"""
Simple Model-Aware Router for decentralized-sharded-ai-orchestrator

This is an initial implementation of the routing layer designed in Task #8.
It reads endpoints.txt and can select backends based on simple rules.

Usage examples:
  python routing/simple-router.py --list
  python routing/simple-router.py --best-for "large-model"

This is a starting point. It can be expanded into a full service later.
"""

import re
import argparse

from typing import List, Dict, Optional


def parse_endpoints(file_path: str = "endpoints/endpoints.txt") -> List[Dict]:
    """Parse endpoints.txt into structured list of backends."""
    backends = []
    try:
        with open(file_path, 'r') as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith('#'):
                    continue
                # Basic parsing: url + comment
                parts = line.split('#', 1)
                url = parts[0].strip()
                comment = parts[1].strip() if len(parts) > 1 else ""

                backend = {'url': url, 'raw_comment': comment}

                # Parse key=value pairs from comment
                for match in re.finditer(r'(\w+)=([^,\s]+)', comment):
                    key, value = match.groups()
                    backend[key] = value

                backends.append(backend)
    except FileNotFoundError:
        print(f"Warning: {file_path} not found")
    return backends


def list_backends(backends: List[Dict]):
    print("Available backends:")
    for b in backends:
        print(f"  {b.get('url')} | provider={b.get('provider', 'unknown')} | cost={b.get('cost', 'N/A')}")


def find_best_backend(backends: List[Dict], preference: str = "default") -> Optional[Dict]:
    """Very basic selection logic. Expand this significantly later."""
    if not backends:
        return None

    if preference == "cheapest":
        # Sort by cost (lower is better)
        sorted_backends = sorted(backends, key=lambda x: float(x.get('cost', 999)))
        return sorted_backends[0]
    elif preference == "local":
        for b in backends:
            if b.get('provider') == 'local':
                return b
        return backends[0]  # fallback
    else:
        # Default: return first available
        return backends[0]


def main():
    parser = argparse.ArgumentParser(description="Simple backend router")
    parser.add_argument('--list', action='store_true', help='List all backends')
    parser.add_argument('--best-for', type=str, default='default',
                        help='Select best backend (cheapest, local, default)')
    args = parser.parse_args()

    backends = parse_endpoints()

    if args.list:
        list_backends(backends)
    else:
        best = find_best_backend(backends, args.best_for)
        if best:
            print(f"Selected backend: {best['url']}")
            print(f"  provider={best.get('provider')}, cost={best.get('cost')}")
        else:
            print("No backends available.")


if __name__ == "__main__":
    main()