# Workflow Scaffold for decentralized-sharded-ai-orchestrator

This repository uses a document-driven, stage-gated agentic engineering workflow optimized for Grok (and future AI agents). The goal is durable context persistence across sessions, smaller scoped tasks, reduced context drift, clearer review boundaries, and consistent code/infrastructure changes.

## How Grok Should Use This Workflow

1. **Always start here** or with the current active stage in `docs/workflow/active/`.
2. Follow stages **in order** unless a handoff explicitly jumps.
3. Read the corresponding prompt in `docs/workflow/prompts/` for the current stage.
4. Read stable guardrails in `.grok/` first on every new session.
5. Use `docs/workflow/active/*.md` as living memory for the current engineering effort.
6. Produce only the outputs specified for that stage.
7. When done with a stage, update the active artifact and move to the next (or archive via handoff).

## Stage Order (Typical Flow)

1. Requirements analysis (`01-requirements.md`)
2. Repo reconnaissance (`02-repo-scan.md`)
3. Architectural design (`03-architecture.md`)
4. Implementation planning (`04-implementation-plan.md`)
5. Implementation (`05-change-log.md` + code/config changes)
6. Verification and testing (`06-test-plan.md` + `06-test-results.md`)
7. Review and hardening (`07-review.md`)
8. Session handoff / next-session context (`08-next-session.md`)

## Where Things Live

- **Active state**: `docs/workflow/active/`
- **Prompt scripts**: `docs/workflow/prompts/`
- **Templates**: `docs/workflow/templates/`
- **Decisions**: `docs/workflow/decisions/`
- **Archive**: `docs/workflow/archive/` (past completed sessions)
- **Guardrails**: `.grok/` (read first every session)
- **Architecture notes for Grok**: `docs/architecture/grok-integration.md`

## Handoffs Reduce Context Drift

Each session ends with `08-next-session.md` (or a handoff template). Future Grok sessions read the latest handoff + active artifacts + guardrails to resume without rediscovering everything.

## For Human Contributors

Follow the same stages when proposing changes. Use decision records for significant choices. Keep changes minimal and interface-preserving.