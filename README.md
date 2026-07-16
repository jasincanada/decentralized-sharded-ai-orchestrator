# decentralized-sharded-ai-orchestrator

**A production-ready orchestration layer for running sharded vLLM inference across local hardware, self-hosted servers, and decentralized compute providers (Akash, io.net, etc.).**

> **For Grok and future agents:** This repository now includes a full document-driven, stage-gated workflow scaffold in `docs/workflow/`. See [docs/workflow/README.md](docs/workflow/README.md) for how to operate. Always start new sessions by reading the `.grok/` guardrails and latest handoff.

Connect your RTX 3070 Ti (or other GPUs), Ubuntu servers, and decentralized nodes into a unified, load-balanced, monitored inference cluster — perfect for personal AI sovereignty, agentic workflows, Continue.dev integration, and high-throughput coding/generation tasks.

## Features

- **Dynamic Nginx Load Balancing** — Least connections with automatic upstream updates from a simple `endpoints.txt` file
- **Multi-Node vLLM Support** — Local Windows 11 + Docker Desktop, Ubuntu servers, Akash deployments
- **Full Observability** — Prometheus + Grafana dashboards for requests/sec, tokens/sec, latency, GPU memory, per-node metrics
- **One-Command Setup** — Robust bash script for Ubuntu 25.04 with Docker + NVIDIA Container Toolkit
- **Windows 11 Ready** — PowerShell script for RTX 3070 Ti via Docker Desktop + vLLM
- **Decentralized Deployments** — Akash SDL example (Qwen2.5-Coder or similar)
- **Production Hardening** — Health checks, proxy headers, proper timeouts, commented configs
- **Developer Friendly** — Continue.dev integration, clear daily workflow, CI with shellcheck

## Quick Start

See [GETTING_STARTED.md](GETTING_STARTED.md) for the fastest path:
- Ubuntu Server 25 setup
- Adding your Windows 11 3070 Ti node
- Connecting decentralized providers
- Using with Continue.dev

## Workflow for Agents & Contributors

This repo uses an 8-stage document-driven workflow for all engineering work. See `docs/workflow/README.md` for details, prompts, templates, and guardrails designed to maintain context across sessions.

Future enhancements will include support for additional providers (AIOZ, Dynex, etc.) and advanced sharding strategies for frontier models.

## Architecture Overview

```
User / Agents / Continue.dev
          │
          ▼
Nginx Reverse Proxy (least_conn)
          │
    ┌────┤─────┐
    ▼           ▼
Local vLLM   Decentralized
(Win11 3070)   (Akash/io.net)
    │           │
Prometheus + Grafana Monitoring
```

## Project Status

- **Current Version**: v0.1.0 (Initial release + workflow scaffold)
- **Status**: Production-ready core orchestration + new agentic workflow system
- **Tested On**: Ubuntu 25.04, Windows 11 + Docker Desktop, Akash testnet

## License

MIT License — see [LICENSE](LICENSE) file.

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) and follow the workflow in `docs/workflow/`.

Built for personal AI infrastructure sovereignty and high-performance decentralized inference.