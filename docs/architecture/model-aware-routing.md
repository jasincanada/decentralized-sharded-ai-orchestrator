# Model-Aware Routing Layer Design (Task #8)

**Date**: 2026-07-16
**Status**: Design Complete
**Related Tasks**: #8, #9 (Sharding)

## Goal
Enable intelligent selection of backends based on model requirements (size, capabilities, tensor-parallel needs) instead of simple least_conn load balancing.

## Current State
The system currently uses Nginx `least_conn` for all traffic. This works well for homogeneous nodes but is not optimal when mixing:
- Small coding models
- Large frontier models
- Nodes with different GPU memory / tensor-parallel support

## Proposed Approach

### Phase 1 (Lightweight)
- Keep Nginx as the fast path for most traffic.
- Add an optional lightweight routing script (Python or Bash) that can pre-select a backend based on simple rules (model name, size hints).
- Store basic model metadata in `endpoints.txt` comments or a small JSON sidecar.

### Phase 2 (More Intelligent)
- Introduce a small routing service (or enhance `manage_endpoints.sh`).
- Support rules like:
  - "If model > 30B params → prefer nodes with ≥ 2x GPUs or high VRAM"
  - "Prefer lowest cost provider for this model"
  - Basic fallback chain

### Integration with Existing System
- The core Nginx + `endpoints.txt` remains the stable foundation.
- New routing logic sits **in front of** or **alongside** Nginx.
- Can start very simple (even a small script that rewrites the upstream temporarily).

## Decision
Start with documentation + metadata in comments. Implement actual routing logic only when we have concrete multi-provider setups (after Tasks 6 & 7 examples are expanded with real endpoints).

This keeps changes minimal and avoids over-engineering.