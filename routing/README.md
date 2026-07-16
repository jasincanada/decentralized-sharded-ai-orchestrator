# Routing Layer (Foundational)

This is the core intelligent routing component of the orchestrator.

## Status
- Production-oriented foundation implemented
- Supports rich metadata, multiple strategies, model awareness, and provider preference
- Ready for integration with provider tooling (AIOZ, Dynex, etc.)

## Key Features
- `cheapest`, `local`, `balanced` strategies
- `--model-size large` awareness
- `--provider aioz` preference
- JSON output for scripting/integration
- Clean fallback behavior

## Usage Examples

```bash
# Basic balanced selection
python routing/simple-router.py --best-for balanced

# Prefer AIOZ nodes for cost reasons
python routing/simple-router.py --best-for cheapest --provider aioz

# Good for large models
python routing/simple-router.py --best-for balanced --model-size large

# JSON for automation
python routing/simple-router.py --best-for cheapest --json
```

## Integration Points
- Can be called from scripts or future orchestration layer
- Works with metadata from `endpoints.txt` (including AIOZ/Dynex cost data)
- Foundation for more advanced routing + sharding logic

## Next Steps
- Add fallback chains
- Integrate cost tracking more deeply
- Support for frontier model sharding decisions
- Optional FastAPI wrapper for service mode