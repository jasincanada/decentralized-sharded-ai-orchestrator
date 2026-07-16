# Sharding Support (Matured)

## Tools
- `suggest-shard.sh` — Mature helper for tensor-parallel node selection
  - Filters by minimum GPU count
  - Shows total available capacity
  - JSON output for automation
  - Practical recommendations for vLLM

## Integrated Workflow
```bash
# 1. Find suitable nodes
./sharding/suggest-shard.sh 2

# 2. Use routing for intelligent final selection
python routing/simple-router.py --best-for balanced --model-size large

# 3. Run vLLM with tensor-parallel
vllm ... --tensor-parallel-size 2 --model <large-model>
```

## Metadata Requirements
Nodes should have `gpus=` in `endpoints.txt` comments for best results.

## Current Maturity
Sharding support is now practical and integrated with routing.
It can be used for real deployment of large models across multiple nodes.

## Future Enhancements
- Automated optimal group selection
- Cost-aware sharding
- Heterogeneous hardware support
- Integration with full orchestrator for automatic placement