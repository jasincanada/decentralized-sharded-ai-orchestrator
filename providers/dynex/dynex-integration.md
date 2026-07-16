# Dynex Integration

**Status**: Real integration at same maturity as AIOZ

## Overview
Dynex provides decentralized GPU compute suitable for inference workloads.

## Tools
- `dynex-register.sh` — Add and test Dynex nodes (follows provider template)

## Usage

### Add a Real Dynex Node
```bash
./providers/dynex/dynex-register.sh add \
    http://your-real-dynex-endpoint:8000 \
    "Dynex-Production-Node" \
    0.10
```

Then:
```bash
./manage_endpoints.sh
```

### Test a Dynex Node
```bash
./providers/dynex/dynex-register.sh test http://your-real-dynex-endpoint:8000
```

## Metadata
Uses standard fields:
- `provider=dynex`
- `name=`
- `cost=`
- `gpus=`

## Integration
- Works with routing layer (`--provider dynex`, cost-aware strategies)
- Works with sharding tools via `gpus=` metadata
- Follows the provider template in `providers/template/`

## Next Steps
- Expand with more Dynex-specific features if needed
- Add to cost tracking dashboards