# Routing Layer

This directory contains the model-aware / intelligent routing components.

## Current Status
- `simple-router.py` — Initial working router (Task #8 design)
- Can list backends and do basic selection (cheapest, local, default)

## Next Steps
- Integrate with Nginx or a lightweight proxy
- Add model size awareness
- Support for frontier model sharding decisions
- Cost + latency aware routing

This is the foundation for the full routing implementation.