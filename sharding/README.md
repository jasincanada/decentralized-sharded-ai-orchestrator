# Sharding Support (Deepened)

## Tools
- `suggest-shard.sh` — Enhanced helper that suggests suitable nodes for tensor-parallel sharding.
  - Supports JSON output
  - Filters by minimum GPU count

## Integration with Routing
The routing layer can already prefer high-GPU nodes using `--model-size large`.
You can combine:
```bash
# Get nodes good for sharding size 2
./sharding/suggest-shard.sh 2

# Then use routing to pick the best among them
python routing/simple-router.py --best-for balanced --model-size large
```

## Current Capabilities
- Basic node suggestion for tensor-parallel
- GPU metadata driven
- JSON output for scripting
- Works with AIOZ and other providers via metadata

## Roadmap
- Automated optimal group selection
- Cost-aware sharding decisions
- Integration with full routing for large model placement
- Support for heterogeneous node groups