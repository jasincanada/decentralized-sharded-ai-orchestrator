# Trigger: Stage 03 - Architectural Design

## Read First
- .grok/system-context.md
- .grok/coding-constraints.md
- docs/workflow/active/01-requirements.md
- docs/workflow/active/02-repo-scan.md
- Existing key files (nginx config, manage_endpoints.sh, endpoints.txt)

## Task
Design the architecture for the current goal, considering how it extends the existing foundation (especially for future AIOZ/Dynex and sharding support).

## Focus
Pluggable extensions rather than core changes. Leverage existing dynamic backend model.

## Constraints
- Do not propose breaking changes to current Nginx or endpoints format.
- Distinguish scaffold work from future implementation.

## Output
Update docs/workflow/active/03-architecture.md with findings, proposed evolution, and decisions.

## Stop Condition
Architecture documented. Proceed to implementation planning.