# Sharding Support (Integrated with Routing)

## Tools
- `suggest-shard.sh` — Suggests nodes with sufficient GPUs
- Routing layer now uses GPU count when `--model-size large` is specified

## Integrated Workflow
The routing and sharding tools are designed to work together:

1. Use `suggest-shard.sh` to find candidate nodes
2. Use the router with `--model-size large` to pick the best one

This is foundational integration between intelligent routing and sharding decisions.