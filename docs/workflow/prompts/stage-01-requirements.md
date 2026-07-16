# Trigger: Stage 01 - Requirements Analysis

## Read First
- .grok/system-context.md
- .grok/coding-constraints.md
- docs/workflow/README.md
- Current user request or previous handoff (08-next-session.md)

## Task
Analyze the request and extract clear, scoped requirements. Distinguish what must be done now vs future.

## Focus
One narrow session goal. For this bootstrap: Establish the full workflow scaffold + guardrails.

## Constraints
- Smallest viable set of changes.
- Do not rewrite existing scripts or configs unless required for the scaffold.
- Mark missing information explicitly.
- Note AIOZ/Dynex/frontier sharding support as future requirement, not current implementation.

## Output
Update docs/workflow/active/01-requirements.md with:
- Objective, Inputs, Constraints, Findings, Decisions, Open Questions, Next Action, Status
- Clear separation of scaffold work vs future feature work.

## Stop Condition
Once 01-requirements.md is updated with repo-aware content and the next stage is identified, stop. Do not proceed to implementation.