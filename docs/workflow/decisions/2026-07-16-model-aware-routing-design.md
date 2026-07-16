# Decision Record: Model-Aware Routing Layer

**Date**: 2026-07-16
**Task**: #8

## Context
Current least_conn works for basic multi-node setups but doesn't intelligently route based on model size or node capabilities.

## Decision
Adopt a gradual design:
- Document the approach now.
- Keep Nginx stable.
- Add metadata in endpoints comments.
- Defer actual routing code until we have real multi-provider data.

## Rationale
- Smallest viable
- Avoids complexity before we need it
- Builds on the provider examples from Phase 2

## Next Steps
Task #9 (Basic sharding strategy) can reference this design.