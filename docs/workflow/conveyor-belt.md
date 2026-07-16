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

| Capability Area              | Current Maturity      | Target (6-12 mo)     | Key Gaps / Next Tasks                          | Notes |
|------------------------------|-----------------------|----------------------|------------------------------------------------|-------|
| Core Orchestration (Nginx + dynamic endpoints) | Mature (v0.1.0)      | Production-Ready    | Auth (done), health checks (done), systemd (done) | Strong foundation |
| Windows 11 + 3070 Ti Support | Partial              | Mature              | Better WSL2 integration, multi-GPU, firewall helpers | Good start |
| Provider Extensibility       | Planning             | Mature              | Abstraction layer design, AIOZ & Dynex support | Explicit future work |
| Intelligent Routing & Sharding | Not Started        | Partial             | Model-aware routing, frontier model sharding strategies | High value for large models |
| Observability & Monitoring   | Good                 | Excellent           | Cost tracking, per-provider metrics, alerting | Grafana dashboard exists |
| Ease of Node Addition        | Good                 | Excellent           | One-command node registration, validation     | `manage_endpoints.sh` + endpoints.txt |
| Security & Hardening         | Improved             | Strong              | Rate limiting, secrets management | Tasks 1+2 done |
| Documentation & Onboarding   | Good                 | Excellent           | Video guides, troubleshooting, more examples  | Workflow scaffold now in place |
| Agentic / RAG Integration    | Not Started          | Partial             | Native hooks for Continue.dev, LangGraph, personal Oracle | Future integration point |

## Prioritized Task Backlog

Tasks are small and dependency-aware. Status: **Ready** | **In Progress** | **Blocked** | **Done**.

### Phase 1: Foundation & Stability (Current Focus)

1. **Add basic authentication to the Nginx proxy**  
   **Status: Done**

2. **Improve health checking and automatic node management**  
   **Status: Done**  
   Notes: Added `--health-check` flag

3. **Add systemd service files for easier Ubuntu management**  
   **Status: Done** (2026-07-16)
   Notes: Added example systemd/ directory with vllm.service and orchestrator.service

4. **Enhance Windows 11 setup experience**  
   **Status: Ready**  
   Dependencies: None  
   Notes: Better error handling, multi-GPU detection, firewall/port forwarding guidance.

### Phase 2: Provider Extensibility (High Priority Future)

5. **Design pluggable provider abstraction**  
   **Status: Ready (planning)**  
   Dependencies: Phase 1 tasks done  
   Notes: Define how new providers (AIOZ, Dynex, others) register endpoints.

6. **Initial AIOZ provider support**  
   **Status: Not Started**  
   Dependencies: Task 5  
   Notes: Research AIOZ inference endpoints.

7. **Initial Dynex provider support**  
   **Status: Not Started**  
   Dependencies: Task 5  
   Notes: Similar to AIOZ.

### Phase 3: Intelligent Routing & Frontier Model Sharding

8. **Model-aware routing layer (planning)**  
   **Status: Not Started**  
   Dependencies: Task 5  
   Notes: Decide where logic lives.

9. **Basic sharding strategy for large/frontier models**  
   **Status: Not Started**  
   Dependencies: Task 8  
   Notes: Tensor-parallel + intelligent dispatch.

### Phase 4: Observability, Operations & Hardening (Parallel Track)

10. **Add cost & usage tracking for decentralized nodes**  
    **Status: Ready**  
    Dependencies: None  
    Notes: Extend Grafana or add simple scripts.

11. **Security hardening pass**  
    **Status: Ready**  
    Dependencies: Phase 1 done  
    Notes: Rate limiting, secrets management, Cloudflare examples.

12. **Expand test/CI coverage**  
    **Status: Ready**  
    Dependencies: None  
    Notes: More validation for new configs.

### Ongoing / Evergreen

- Documentation improvements and example expansions
- Roadmap and conveyor-belt backlog grooming after each major task
- Integration points with personal AI Oracle / RAG systems (when user requests)

## How to Add New Tasks

When a new requirement appears (from user, roadmap, or during a task):
1. Create a short entry in the appropriate phase above.
2. Give it a clear title, status, dependencies, and notes.
3. If it touches architecture or interfaces, create a decision record in `docs/workflow/decisions/`.
4. Update the Maturity Dashboard.

## Integration with Existing Workflow

This conveyor belt **is** the long-term operating system on top of the 8-stage scaffold. Every task listed here is executed by following the prompts in `docs/workflow/prompts/` and updating the active artifacts.

After completing a task, always return here to mark it **Done**, update the dashboard, and pick the next ready item.

## Vision
Over time this repo evolves from a solid v0.1.0 orchestration foundation into a mature, extensible, observable platform for personal + decentralized sharded inference — with clean support for multiple providers (Akash today, AIOZ, Dynex, and others tomorrow) and intelligent strategies for running frontier-scale models across heterogeneous hardware.

The conveyor belt ensures this happens gradually, reliably, and with full context preservation across dozens of Grok sessions.