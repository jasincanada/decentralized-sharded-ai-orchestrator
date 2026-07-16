# decentralized-sharded-ai-orchestrator

**A production-ready orchestration layer for running sharded vLLM inference across local hardware, self-hosted servers, and decentralized compute providers (Akash, io.net, etc.).**

Connect your RTX 3070 Ti (or other GPUs), Ubuntu servers, and decentralized nodes into a unified, load-balanced, monitored inference cluster — perfect for personal AI sovereignty, agentic workflows, Continue.dev integration, and high-throughput coding/generation tasks.

## Features

- **Dynamic Nginx Load Balancing** — Least connections with automatic upstream updates from a simple `endpoints.txt` file
- **Multi-Node vLLM Support** — Local Windows 11 + Docker Desktop, Ubuntu servers, Akash deployments
- **Full Observability** — Prometheus + Grafana dashboards for requests/sec, tokens/sec, latency, GPU memory, per-node metrics
- **One-Command Setup** — Robust bash script for Ubuntu 25.04 with Docker + NVIDIA Container Toolkit
- **Windows 11 Ready** — PowerShell script for RTX 3070 Ti via Docker Desktop + vLLM
- **Decentralized Deployments** — Akash SDL example (Qwen3.5-Coder or similar)
- **Production Hardening** — Health checks, proxy headers, proper timeouts, commented configs
- **Developer Friendly** — Continue.dev integration, clear daily workflow, CI with shellcheck

## Quick Start

See [GETTING_STARTED.md](GETTING_STARTED.md) for the fastest path:
- Ubuntu Server 25 setup
- Adding your Windows 11 3070 Ti node
- Connecting decentralized providers
- Using with Continue.dev

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

- **Current Version**: v0.1.0 (Initial release)
- **Status**: Production-ready core (Nginx orchestration + monitoring + setup scripts)
- **Tested On**: Ubuntu 25.04, Windows 11 + Docker Desktop, Akash testnet

## License

MIT License — see [LICENSE](LICENSE) file.

## Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

Built for personal AI infrastructure sovereignty and high-performance decentralized inference.