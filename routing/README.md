# Routing Layer (Foundational - Enhanced)

The routing layer is now a core part of the orchestrator's intelligence.

## Key Improvements
- Fallback chain logic (preferred provider → model size → general)
- Better integration with provider metadata (AIOZ, cost, GPU count)
- More robust selection with `select_with_fallback()`
- Cleaner structure for future expansion

## Usage

```bash
# Prefer AIOZ, fall back gracefully
python routing/simple-router.py --best-for cheapest --provider aioz

# Large model with fallback
python routing/simple-router.py --best-for balanced --model-size large
```

## System Integration
The router reads from `endpoints.txt` and understands provider-specific metadata added by tools like `providers/aioz/aioz-register.sh`.

This creates a foundation where:
- Adding a new provider automatically makes it available to routing
- Cost and capability metadata flows through the system
- We can gradually add more intelligence (sharding decisions, etc.)

## Next Steps
- Deeper cost tracking integration
- Sharding-aware routing
- Optional service mode (FastAPI)