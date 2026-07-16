# Repository Map - decentralized-sharded-ai-orchestrator

**Purpose:** Quick reference for Grok to understand the actual structure without re-inspecting every time.

## Root Level (Key Files)
- README.md (updated with workflow pointer)
- GETTING_STARTED.md
- CHANGELOG.md
- ROADMAP.md
- setup_orchestrator.sh (Ubuntu bootstrap with Docker + NVIDIA)
- manage_endpoints.sh (dynamic Nginx upstream from endpoints.txt)
- LICENSE, CONTRIBUTING.md

## Core Orchestration
- nginx/vllm-orchestrator.conf (reverse proxy, least_conn, health check, streaming-friendly)
- endpoints/endpoints.txt (source of truth for backend URLs + comments)

## Monitoring & Observability
- prometheus/prometheus.yml (vllm-sharded job)
- grafana/provisioning/datasources/vllm.yml
- grafana/dashboards/vllm-sharded.json (requests/sec, tokens/sec, latency, GPU memory)

## Deployment Examples
- decentralized-deploy/akash-vllm.yaml (SDL for Qwen-style model on Akash)

## Windows Support
- win11-setup/setup.ps1 (Docker Desktop + RTX 3070 Ti vLLM container)

## CI & Quality
- .github/workflows/ci.yml (shellcheck, YAML validation, required files check)

## New Workflow System (added in this session)
- docs/workflow/ (8-stage scaffold, prompts, templates)
- .grok/ (guardrails: system-context, coding-constraints, repository-map, style-contract)
- docs/architecture/grok-integration.md

## Conventions Observed
- Heavy use of comments in Bash scripts
- Dynamic config via simple text files (endpoints.txt)
- Emphasis on health checks, timeouts, and observability
- No application code yet; infrastructure/config focused

## Gaps / Future Areas
- No provider abstraction layer yet (current: direct Akash + local)
- AIOZ, Dynex, and frontier model sharding planned for later stages
- No Python/FastAPI orchestrator layer yet