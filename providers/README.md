# Provider System (Improved)

This directory provides a clean structure for integrating different decentralized providers.

## Current Structure

```
providers/
├── aioz/                    # AIOZ Network
│   ├── aioz-register.sh
│   └── aioz-integration.md
└── README.md
```

## Design Principles
- Keep core orchestrator (Nginx + endpoints.txt) stable
- Each provider has its own directory with registration/testing tools
- Metadata flows into routing layer automatically
- Easy to add new providers (Dynex, etc.)

## Integration with Routing
The routing layer (`routing/simple-router.py`) reads provider metadata from `endpoints.txt`.
Tools like `aioz-register.sh` make it easy to add well-formed entries.

## Adding a New Provider
1. Create `providers/<name>/`
2. Add a `*-register.sh` helper
3. Document integration in `*-integration.md`
4. Update this README

This creates a scalable, clean foundation for multi-provider support.