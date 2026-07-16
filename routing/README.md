# Routing Layer (Advanced Foundational)

The routing layer has been further expanded with more advanced capabilities.

## New Features
- `smart` strategy with multi-criteria weighted scoring
- Better sharding awareness (prefers high-GPU nodes for large models)
- Strong cost integration
- Prepared structure for future service mode (FastAPI / HTTP endpoint)

## Advanced Usage

```bash
# Use the smart strategy (recommended)
python routing/simple-router.py --best-for smart

# Smart + large model sharding awareness
python routing/simple-router.py --best-for smart --model-size large

# Prefer a specific provider
python routing/simple-router.py --best-for smart --provider aioz
```

## Architecture Notes
The router is designed to be the intelligence layer that sits above the stable Nginx + endpoints.txt core.
It can be used as a CLI tool today and can evolve into a lightweight service later.

This is now a mature foundational routing component.