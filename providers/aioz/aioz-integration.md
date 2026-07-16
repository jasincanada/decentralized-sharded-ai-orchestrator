# AIOZ Network Integration

**Status**: Foundation + helper script created

## Overview
AIOZ Network provides decentralized GPU compute suitable for LLM inference.

## Current Integration Level
- Structured `providers/aioz/` directory
- Helper script (`aioz-register.sh`)
- Cost + provider metadata support in `endpoints.txt`
- This document

## Quick Start (Real Usage)

### 1. Add a Real AIOZ Node

```bash
./providers/aioz/aioz-register.sh add \
    http://your-real-aioz-endpoint:8000 \
    "AIOZ-Node-Production" \
    0.12
```

Then run:
```bash
./manage_endpoints.sh
```

to update the Nginx load balancer.

### 2. Test an AIOZ Node

```bash
./providers/aioz/aioz-register.sh test http://your-real-aioz-endpoint:8000
```

### 3. Metadata Format

```bash
http://aioz-endpoint:8000   # provider=aioz, name=MyNode, cost=0.12, gpus=2x4090
```

## Next Steps for Full Integration
- Add AIOZ-specific authentication handling (if required by their platform)
- Create Grafana panels for AIOZ cost tracking
- Integrate with the routing layer (`routing/simple-router.py`) for cost-aware selection
- Monitor health more aggressively for decentralized nodes

## Notes
Replace placeholder URLs with actual AIOZ endpoints from your AIOZ dashboard or provider marketplace.