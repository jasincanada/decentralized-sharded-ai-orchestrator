# Provider System (Mature Abstraction)

The provider system now supports multiple providers at consistent maturity.

## Current Providers
- `aioz/` — Full integration (register script + docs + routing support)
- `dynex/` — Full integration (register script + docs + routing support)

## Structure
```
providers/
├── aioz/
├── dynex/
├── template/
└── README.md
```

## Key Features
- Consistent registration/testing pattern
- Automatic routing integration via metadata
- Works with sharding tools
- Easy to extend

This is now a mature, scalable provider abstraction layer.