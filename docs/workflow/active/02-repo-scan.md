## Objective
Map the current repository structure, entrypoints, conventions, and gaps to inform architecture and changes.

## Inputs
- Full repo tree (via GitHub tools or ls)
- Key files: README.md, setup_orchestrator.sh, manage_endpoints.sh, nginx/vllm-orchestrator.conf, endpoints/endpoints.txt, prometheus/, grafana/, decentralized-deploy/akash-vllm.yaml, win11-setup/setup.ps1, .github/workflows/ci.yml

## Constraints
- Only describe what actually exists. Do not hallucinate modules.
- Note that this is primarily infrastructure/config repo (Bash + configs), not a large application.

## Findings
**Core Structure (as of inspection):**
- Root: README, GETTING_STARTED, CHANGELOG, ROADMAP, LICENSE, CONTRIBUTING, setup scripts, manage_endpoints.sh
- nginx/: vllm-orchestrator.conf (dynamic upstream via include)
- endpoints/: endpoints.txt (source of truth for backends)
- prometheus/: prometheus.yml
- grafana/: provisioning + dashboard JSON
- decentralized-deploy/: akash-vllm.yaml
- win11-setup/: setup.ps1
- .github/workflows/: ci.yml (shellcheck + validation)

**Entrypoints for orchestration:**
- manage_endpoints.sh (rebuilds Nginx upstream)
- setup_orchestrator.sh (Ubuntu bootstrap)
- Docker/vLLM containers on nodes

**Current State:** v0.1.0 foundation is present and functional for basic multi-node vLLM with monitoring. No application code, no provider abstraction layer yet.

## Decisions
- The workflow scaffold will be additive (new docs/ and .grok/ directories).
- Future provider support (AIOZ, Dynex, frontier sharding) will require new abstraction in later stages.

## Open Questions
- None critical for scaffold bootstrap.

## Next Action
Stage 03: Architectural design.

## Status
Repo scan complete. Structure well understood.