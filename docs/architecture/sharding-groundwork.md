# Sharding Groundwork (Foundational)

**Date**: 2026-07-16
**Status**: Initial groundwork laid

## Goal
Prepare the system to support tensor-parallel and multi-node sharding for large/frontier models.

## Current Foundations
- Multi-node support already exists via Nginx + `endpoints.txt`
- Routing layer can now consider GPU count (`gpus=` metadata)
- Model-size awareness exists in the router (`--model-size large`)

## Sharding-Related Metadata
We now support these fields in `endpoints.txt`:

```bash
http://node1:8000   # provider=local, gpus=2, model=large
http://node2:8000   # provider=local, gpus=2, model=large
```

The router can already prefer nodes with sufficient GPUs when `--model-size large` is used.

## Next Steps for Full Sharding
1. Add a sharding helper script (suggest node groups for tensor-parallel)
2. Integrate sharding decisions into the routing layer
3. Document recommended tensor-parallel-size configurations
4. Support for heterogeneous node sharding (different GPU types)

## Design Principle
Keep the core Nginx orchestrator simple. Sharding intelligence should live in the routing layer or dedicated helpers, not in the critical path.

This groundwork allows us to gradually add real sharding support without disrupting existing functionality.