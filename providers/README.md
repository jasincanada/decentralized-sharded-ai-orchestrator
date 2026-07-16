# Provider System

This directory holds integration for different decentralized compute providers.

## Current Providers
- `aioz/` — AIOZ Network integration (helper script + docs)

## Design Goal
Create a consistent way to add and manage providers while keeping the core orchestrator (Nginx + endpoints.txt) stable.

## Recommended Structure for New Providers

```
providers/
├── aioz/
│   ├── aioz-register.sh
│   └── aioz-integration.md
└── dynex/          # Future
    ├── dynex-register.sh
    └── dynex-integration.md
```

## Integration with Routing
The `routing/simple-router.py` can already use `provider=` metadata from endpoints.txt.
This allows cost-aware or provider-preferred routing.