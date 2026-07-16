# Sharding Support (Groundwork)

This directory contains tools to help with tensor-parallel and multi-node sharding.

## Current Tool
- `suggest-shard.sh` — Suggests nodes with sufficient GPUs for a given tensor-parallel size.

## Usage
```bash
./sharding/suggest-shard.sh 2    # Nodes good for --tensor-parallel-size 2
./sharding/suggest-shard.sh 4    # Nodes good for --tensor-parallel-size 4
```

## Integration
Works with GPU metadata (`gpus=`) in `endpoints.txt`.
Can be combined with the routing layer for more intelligent decisions.

## Future
- Automated sharding group selection
- Integration with routing for large model placement
- Support for heterogeneous hardware sharding

This is foundational groundwork for supporting frontier-scale models.