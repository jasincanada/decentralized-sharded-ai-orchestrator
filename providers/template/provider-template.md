# Provider Template

Use this as a guide when adding a new provider (e.g. Dynex, Vast.ai, io.net, etc.).

## Recommended Files

```
providers/<provider-name>/
├── <provider-name>-register.sh     # Helper to add/test nodes
├── <provider-name>-integration.md   # Documentation
└── README.md                       # Short description
```

## Metadata Standard

When adding entries to `endpoints.txt`, use these common fields:

- `provider=` (e.g. aioz, dynex, local)
- `name=` (human readable name)
- `cost=` (cost per unit)
- `gpus=` (number of GPUs)
- `model=` (supported models, optional)

Example:
```bash
http://node.example.com:8000   # provider=dynex, name=Dynex-Node-1, cost=0.10, gpus=4
```

## Integration with Routing

The router (`routing/simple-router.py`) automatically understands these fields.
No code changes needed in routing when adding new providers.

## Best Practices
- Keep the core Nginx + `endpoints.txt` system stable
- Put provider-specific logic in the provider's own directory
- Use the register script pattern for consistency
- Document real usage clearly

This pattern makes the provider system scalable and maintainable.