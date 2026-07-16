# AIOZ Network Integration

**Status**: Foundation created (ready for real endpoints)

## Overview
AIOZ Network provides decentralized GPU compute that can be used as inference backends.

## Current Integration Level
- Basic example added in `endpoints.txt`
- Cost metadata support added
- This document provides the structure for real integration

## How to Add a Real AIOZ Node

1. Get your AIOZ inference endpoint (from AIOZ dashboard or provider).
2. Add it to `endpoints/endpoints.txt`:

```bash
http://your-aioz-endpoint:8000   # provider=aioz, name=AIOZ-Node-1, cost=0.12, model=Qwen2.5-Coder
```

3. (Optional) Add health check and cost tracking once the node is live.

## Recommended Metadata Fields
- `provider=aioz`
- `name=` (human readable)
- `cost=` (per 1M tokens or per hour)
- `model=` (what model(s) it supports)
- `gpus=` (number and type of GPUs)

## Future Enhancements
- AIOZ-specific authentication (if required)
- Cost tracking dashboard panel
- Automatic endpoint discovery (if AIOZ provides an API)

## Notes
AIOZ integration is currently at the "example + structure" stage. Replace the placeholder with real endpoints when available.