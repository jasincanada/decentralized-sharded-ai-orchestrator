# Decision Record: Basic Sharding Strategy

**Date**: 2026-07-16
**Task**: #9

## Context
We want to support large/frontier models by sharding them across nodes, building on the existing multi-node infrastructure.

## Decision
Take a documentation-first + metadata approach:
- Add capability hints in endpoints comments.
- Provide examples for tensor-parallel usage.
- Defer complex automated routing/sharding until we have more real-world multi-provider data.

## Rationale
- Keeps changes minimal
- Builds directly on Tasks 5-8
- Avoids over-engineering before we need it

## Next Steps
Phase 3 planning is now largely complete. Can move to Phase 4 tasks or expand provider examples with real endpoints.