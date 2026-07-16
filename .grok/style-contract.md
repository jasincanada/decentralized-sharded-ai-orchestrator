# Style Contract for Changes in This Repository

## Naming & Organization
- Scripts: descriptive, hyphenated or snake_case as existing (setup_orchestrator.sh, manage_endpoints.sh)
- Configs: Keep existing patterns (nginx/, prometheus/, grafana/)
- Documentation: Clear headings, consistent structure (Objective / Inputs / Constraints / Findings / Decisions / Open Questions / Next Action / Status for active stages)

## Comments & Documentation
- All Bash scripts and significant config sections must have explanatory comments.
- New markdown must follow the standard active stage structure.
- Decision records go in docs/workflow/decisions/

## Error Handling & Robustness
- Scripts should use set -euo pipefail where appropriate (existing pattern in setup scripts).
- Provide clear error messages and next steps.
- Health checks and timeouts are preferred patterns (see current Nginx config).

## Testing & Validation
- Shell changes must pass shellcheck (CI enforces).
- YAML and JSON must remain valid.
- For new features, add or update test plans in docs/workflow/active/06-test-*.md

## Change Discipline
- Smallest viable change.
- Preserve existing behavior of manage_endpoints.sh and endpoints.txt format.
- Label any uncertainty in active artifacts.
- Never claim support for unimplemented providers (AIOZ, Dynex, frontier sharding) until delivered.

## Logging & Observability
- Leverage existing Prometheus/Grafana where possible.
- New components should expose metrics compatible with current dashboard.