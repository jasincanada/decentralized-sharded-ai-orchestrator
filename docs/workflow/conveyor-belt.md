# Grok Tasks Conveyor Belt

**Purpose**: A systematic, quota-friendly, context-preserving pipeline for gradually developing and maturing the `decentralized-sharded-ai-orchestrator` repository over many Grok sessions (and human contributions).

Instead of big rewrites or context-losing jumps, every meaningful improvement flows through the existing **8-stage workflow** as a small, well-scoped task. This creates a smooth "conveyor belt" of incremental progress.

## Core Principles

- **One focused task per cycle** (or very small batch within one 8-stage run).
- **Full stage discipline**: Every non-trivial task runs through Requirements → Repo Scan → Architecture → Planning → Implementation → Verification → Review → Handoff.
- **Persistent memory**: Active artifacts + handoffs + this conveyor-belt document carry context forward.
- **Smallest viable changes**: Never rewrite unrelated code. Preserve existing interfaces (especially `endpoints.txt`, Nginx config, and monitoring).
- **Explicit future work**: AIOZ, Dynex, and frontier model sharding support are tracked here as planned capabilities, never claimed until delivered.
- **Maturity over features**: Progress is measured by reliability, extensibility, and ease of operation rather than feature count.

## How the Conveyor Belt Operates (for Grok)

1. **Start of session**: Read `.grok/system-context.md`, `.grok/coding-constraints.md`, and the latest `docs/workflow/active/08-next-session.md` (or most recent archived handoff).
2. **Consult the belt**: Open this file (`docs/workflow/conveyor-belt.md`) and identify the highest-priority **Ready** task that has no unmet dependencies.
3. **Execute the task**: Run the full 8-stage workflow using the prompts in `docs/workflow/prompts/`.
   - Update the relevant active stage files.
   - Record changes in `05-change-log.md`.
   - Create decision records when architecture or interfaces are touched.
4. **Complete the cycle**: Finish with `08-next-session.md`, then **update this conveyor-belt document** with new status, progress, and any new tasks discovered.
5. **Archive**: Move completed task artifacts to `docs/workflow/archive/` if desired.
6. **Repeat**: Pick the next ready task in the following session.

This turns long-term development into a reliable, low-drift pipeline.

## Maturity Dashboard (Living)

Track progress across key capability areas. Update after each completed task.

| Capability Area              | Current Maturity           | Target (6-12 mo)     | Key Gaps / Next Tasks                          | Notes |
|------------------------------|----------------------------|----------------------|------------------------------------------------|-------|
| Core Orchestration           | Production-Ready           | Production-Ready     | Phase 1 complete                              | Strong foundation |
| Provider Extensibility       | Real tooling added         | Mature               | Full AIOZ/Dynex integration + abstraction     | AIOZ helper script added |
| Routing & Intelligence       | Significantly improved     | Strong               | Full routing + sharding implementation        | Enhanced router with model awareness |
| Observability & Cost Tracking| Good                       | Excellent            | Per-provider cost panels                      | Basic cost metadata exists |
| Security & Hardening         | Improved                   | Strong               | Secrets management, advanced rate limiting    | Rate limiting enabled |
| Documentation & Onboarding   | Good                       | Excellent            | Video guides, troubleshooting                 | Workflow scaffold in place |
| Agentic / RAG Integration    | Not Started                | Partial              | Native hooks for Continue.dev / LangGraph     | Future work |

## Current Focus Area
Real implementation of AIOZ integration and routing layer is actively progressing.

## Vision
The goal is a mature, observable, extensible sharded inference platform that can intelligently route across local + decentralized providers (including AIOZ, Dynex, etc.) and handle frontier-scale models through sharding.