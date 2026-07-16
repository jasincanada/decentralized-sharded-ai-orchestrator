# Grok Integration Guide for This Repository

## How Grok Must Operate Here

### On Every New Session
1. Read `.grok/system-context.md` first.
2. Read `.grok/coding-constraints.md`.
3. Read the latest `docs/workflow/active/08-next-session.md` (or the most recent handoff).
4. Read the current active stage artifact.
5. Read the corresponding prompt in `docs/workflow/prompts/`.

### During Work
- Modify **only** files required by the current stage.
- Distinguish clearly between:
  - Implemented work
  - Partially implemented / scaffold-only
  - Future requirements (e.g., AIOZ/Dynex support, frontier model sharding)
- Use decision records (`docs/workflow/decisions/`) for any significant choice.
- When in doubt about existing behavior, inspect the actual file rather than assuming.
- Prefer extending existing patterns (dynamic endpoints, monitoring) over inventing new abstractions prematurely.

### Architecture Stability
- The current Nginx + endpoints.txt + monitoring design is the settled foundation.
- New provider support must be designed as pluggable extensions, not breaking changes to the core orchestrator.
- Sharding strategies for frontier models should leverage the existing multi-node least_conn model where possible.

### Output Discipline
- Update the active stage markdown after completing the narrow task.
- Never continue to the next stage in the same response unless the prompt explicitly allows it.
- End with clear next action and status.