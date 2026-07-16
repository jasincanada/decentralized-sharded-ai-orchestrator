# Routing Layer (Foundational - Sharding Aware)

The router is now sharding-aware.

## Sharding Integration
- When `--model-size large` is used, the router prefers nodes with `gpus >= 2`
- This works together with `sharding/suggest-shard.sh`
- GPU count metadata (`gpus=`) from providers is leveraged for sharding decisions

## Recommended Workflow
```bash
# 1. Find suitable nodes for sharding
./sharding/suggest-shard.sh 2

# 2. Let routing pick the best among capable nodes
python routing/simple-router.py --best-for balanced --model-size large
```

## Benefits
- Better placement of large models across heterogeneous nodes
- Cost and capability considered together
- Foundation for more advanced sharding logic later

This creates tighter integration between routing and sharding support.