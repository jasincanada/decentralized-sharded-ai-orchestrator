# Provider Abstraction Design (Task #5)

**Date**: 2026-07-16
**Status**: Design Complete (ready for implementation in future tasks)
**Related Tasks**: #5, #6 (AIOZ), #7 (Dynex)

## Goal
Enable support for additional decentralized GPU/inference providers (AIOZ, Dynex, and similar) without breaking the existing stable core (Nginx dynamic upstreams + `endpoints.txt` + monitoring).

## Core Principles
- Preserve current `endpoints.txt` format as much as possible.
- Keep the Nginx + `manage_endpoints.sh` layer stable.
- Make new providers **pluggable extensions** rather than core changes.
- Maintain observability (Prometheus/Grafana) for all providers.

## Proposed Design

### 1. Endpoint Metadata (Future Enhancement)
Extend `endpoints.txt` comments or add an optional metadata file:

```
http://192.168.1.105:8000   # provider=local, name=Win11-3070Ti, model=Qwen2.5-Coder
http://akash-node:8000         # provider=akash, name=Akash-Qwen, cost=0.3
http://aioz-node:8000          # provider=aioz, name=AIOZ-GPU, cost=0.15
```

Or keep it simple and use a separate `providers/` directory with YAML/JSON per provider.

### 2. Pluggable Components (Future)
- Provider registry / discovery
- Provider-specific health checks or metrics adapters
- Optional cost/priority metadata for routing decisions

### 3. Routing Layer (Phase 3)
Once multiple providers exist, introduce a lightweight routing layer (script or small service) that can:
- Select backends based on model requirements
- Apply cost or latency preferences
- Support basic sharding for large models

### 4. Backward Compatibility
All changes must remain optional. Existing users with only local + Akash nodes should see no difference.

## Implementation Plan (Future Tasks)
- Task #6: Research AIOZ endpoints + minimal integration example
- Task #7: Research Dynex + minimal integration example
- Later: Full provider abstraction + routing logic

## Decision
We will start with simple metadata in comments + provider-specific documentation. Full abstraction code will be added only when we have at least two additional providers to support.

This keeps changes minimal and focused.