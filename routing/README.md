# Routing Layer

This directory contains the intelligent / model-aware routing components.

## Current Status (Improved)
- `simple-router.py` — Enhanced router with:
  - Rich metadata parsing (provider, cost, gpus, model)
  - Multiple selection strategies (`cheapest`, `local`, `balanced`)
  - Basic model-size awareness (`--model-size large`)
  - JSON output for integration

## How to Use

```bash
# List all backends
python routing/simple-router.py --list

# Get cheapest available backend
python routing/simple-router.py --best-for cheapest

# Prefer node good for large models
python routing/simple-router.py --best-for balanced --model-size large

# JSON output (useful for scripts)
python routing/simple-router.py --best-for cheapest --json
```

## Integration Ideas
- Use as a pre-filter before calling Nginx
- Call from `manage_endpoints.sh` or a wrapper
- Feed into a more advanced orchestrator later

## Next Steps
- Add fallback chains
- Integrate cost tracking from AIOZ/Dynex nodes
- Support for frontier model sharding decisions
- Make it a lightweight service (FastAPI) if needed

This is now a functional foundation for full routing implementation.