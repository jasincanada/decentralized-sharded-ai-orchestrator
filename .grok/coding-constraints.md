# Coding & Change Constraints

**Core Rules (apply to every change):**

1. **Smallest viable patch** — Only modify what is required for the current stage. Prefer additive over rewrite.
2. **Preserve interfaces** — Do not change existing scripts, configs, or endpoints format unless explicitly approved in a decision record.
3. **No fake support claims** — Do not claim support for AIOZ, Dynex, or frontier model sharding until actually implemented and tested in later stages.
4. **Infrastructure focus** — This is a config/orchestration repo. Avoid introducing unrelated application frameworks.
5. **Comment discipline** — All scripts and significant configs must have clear comments.
6. **Validation required** — Changes to shell must pass shellcheck (enforced in CI). YAML/JSON must remain valid.
7. **Document decisions** — Use docs/workflow/decisions/ for any architectural or interface choices.
8. **Label uncertainty** — If information is missing or ambiguous, mark it explicitly in the active artifact rather than guessing.

**For this scaffold bootstrap session:**
- Create new documentation and guardrail files only.
- Do not modify existing core scripts (setup_orchestrator.sh, manage_endpoints.sh, etc.) unless the scaffold requires it.