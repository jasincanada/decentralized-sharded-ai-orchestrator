# Decision Record: Provider Abstraction Design

**Date**: 2026-07-16
**Task**: #5 - Design pluggable provider abstraction

## Context
We need a clean way to add support for new decentralized providers (AIOZ, Dynex, etc.) while keeping the current Nginx + dynamic `endpoints.txt` core stable.

## Decision
Adopt a gradual approach:
1. Start with metadata in `endpoints.txt` comments.
2. Create provider-specific documentation and examples.
3. Defer full code-level abstraction until we have concrete providers to integrate.

## Rationale
- Smallest viable change
- Avoids premature complexity
- Preserves backward compatibility

## Consequences
- Easy to add AIOZ/Dynex examples quickly
- Full routing intelligence moved to Phase 3

## Next Steps
Proceed to Task #6 (Initial AIOZ support) after this design.