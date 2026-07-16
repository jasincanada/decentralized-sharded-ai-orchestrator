# Routing Layer (Foundational - Cost Aware)

The routing layer now has improved cost tracking integration.

## Cost-Aware Features
- `cost=` metadata from providers (AIOZ, Dynex, etc.) is parsed and used
- New `cost_aware` strategy that balances cost with GPU capability
- `--best-for cheapest` and `--best-for cost_aware` strategies available
- Cost is shown in all outputs and JSON

## Usage Examples

```bash
# Get the absolute cheapest option
python routing/simple-router.py --best-for cheapest

# Balance cost and performance
python routing/simple-router.py --best-for cost_aware

# Prefer AIOZ for cost reasons
python routing/simple-router.py --best-for cheapest --provider aioz
```

## Integration
Cost data added via `providers/*/register.sh` tools flows automatically into routing decisions.
This creates a foundation for cost-optimized inference across heterogeneous providers.

## Next Steps
- More advanced cost models (per-token vs per-hour)
- Integration with usage tracking
- Cost-based alerting in observability layer