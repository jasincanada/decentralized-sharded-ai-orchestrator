## Objective
Define the high-level architecture for the workflow system and how future provider/sharding support will integrate without breaking the current foundation.

## Inputs
- Repo scan (stage 02)
- Existing Nginx + endpoints + monitoring design
- Requirements including AIOZ, Dynex, frontier model sharding

## Constraints
- Preserve current least_conn dynamic upstream model as the stable core.
- New provider support must be pluggable extensions.
- No breaking changes to endpoints.txt format in this phase.

## Findings
Current architecture is simple and effective: text-file-driven dynamic backends + Nginx proxy + observability. This is ideal for incremental extension.

## Proposed Architecture Evolution
- Keep core orchestrator (Nginx + manage_endpoints) stable.
- Introduce provider abstraction in future stages (e.g., provider plugins or endpoint metadata).
- Sharding strategies: Leverage existing multi-node model; add intelligent routing layer (future FastAPI or script) that can select shards based on model size / capability.
- Monitoring remains central for all providers.

## Decisions
- Workflow scaffold itself is the immediate deliverable.
- AIOZ/Dynex support and frontier sharding will be designed in stage 03/04 of a future session, implemented later.

## Open Questions
- Exact metadata format in endpoints.txt for new providers?
- Routing logic location (Nginx vs separate layer)?

## Next Action
Stage 04: Implementation planning.

## Status
Architecture thinking captured for scaffold and future work.