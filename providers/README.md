# Provider System (Improved Abstraction)

The provider system now has a clearer abstraction and repeatable pattern.

## Goals
- Make adding new providers (Dynex, etc.) easy and consistent
- Keep core orchestrator stable
- Allow routing layer to work automatically with new providers via metadata

## Current Structure

```
providers/
├── aioz/                    # Implemented
├── template/                # Template & guidelines
└── README.md
```

## How to Add a New Provider

1. Copy the structure from `providers/template/`
2. Create `providers/<name>/`
3. Implement a `*-register.sh` helper
4. Write integration documentation
5. Update this README

The routing layer will automatically understand standard metadata fields (`provider=`, `cost=`, `gpus=`, etc.).

## Benefits
- Consistent developer experience
- Minimal changes to core system
- Easy to extend with new decentralized providers

This is foundational work toward a clean multi-provider architecture.