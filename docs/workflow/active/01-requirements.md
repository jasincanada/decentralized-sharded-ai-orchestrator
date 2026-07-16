## Objective
Capture and clarify what needs to be built or changed in this session, including support for additional providers.

## Inputs
- User request or previous handoff
- Existing README, ROADMAP, GETTING_STARTED

## Constraints
- Focus on infrastructure/orchestration (Bash, Nginx, configs, deployment YAML)
- Preserve existing dynamic endpoint and monitoring design
- Smallest viable changes

## Findings
Current repo (v0.1.0) provides Nginx-based dynamic load balancing for vLLM nodes (local Win11 3070 Ti, Ubuntu, Akash). No Python application layer yet. Strong focus on observability and easy node addition.

## Key Requirements for This Scaffold Session
- Implement 8-stage document-driven workflow with persistent markdown artifacts.
- Create durable Grok guardrails in .grok/
- Seed stage artifacts and prompt scripts.
- Update main README with workflow pointer.

## Future Requirements (to be addressed in later stages)
- Add support for additional decentralized GPU/inference providers: **AIOZ, Dynex**, and similar.
- Engineer sharding strategies to access frontier models across heterogeneous nodes.
- Pluggable provider interfaces while keeping current Akash + local focus stable.

## Decisions
- Scaffold first; do not implement provider code in this bootstrap session.
- Note AIOZ/Dynex/sharding as explicit future requirement in architecture and roadmap updates.

## Open Questions
- Exact interface design for new providers (to be decided in stage 03).

## Next Action
Proceed to stage 02: Repo reconnaissance using the prompt in docs/workflow/prompts/stage-02-repo-scan.md.

## Status
Scaffold bootstrap in progress. Requirements captured.