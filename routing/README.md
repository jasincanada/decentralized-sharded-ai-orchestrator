# Routing Layer (Foundational)

The routing layer is a core part of the orchestrator's intelligence and is now better integrated with the overall system.

## Recent Improvements
- Fallback chains
- Better provider integration (AIOZ metadata)
- Integration point added in `manage_endpoints.sh` (`--suggest`)
- Sharding groundwork started (GPU awareness + model-size hints)

## System Integration
- `manage_endpoints.sh --suggest` can now call the router
- Router understands provider-specific fields added by `providers/*/register.sh` tools
- Foundation for sharding-aware decisions is in place

This creates a more cohesive foundation where routing, providers, and core orchestration work together.