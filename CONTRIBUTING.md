# Contributing to decentralized-sharded-ai-orchestrator

Thank you for your interest in contributing! This project aims to make high-performance, sharded LLM inference accessible to individuals using a mix of local consumer GPUs and decentralized compute providers.

## How to Contribute

### Reporting Bugs
- Use the GitHub Issues tab
- Include:
  - Steps to reproduce
  - Expected vs actual behavior
  - Your environment (OS, GPU, Docker version, vLLM version)
  - Relevant logs from Nginx, vLLM, or Prometheus

### Suggesting Enhancements
- Open an issue with the label `enhancement`
- Describe the use case and why it benefits solo operators or small teams
- Reference any related decentralized compute or vLLM discussions

### Pull Requests
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes with clear, well-commented code
4. Test thoroughly (especially Nginx config changes and scripts)
5. Commit with conventional style: `feat:`, `fix:`, `docs:`, etc.
6. Push and open a Pull Request

## Code Style & Quality

- Bash scripts: Use `shellcheck` (CI runs it). Comment non-obvious sections.
- Nginx configs: Keep proxy settings consistent; document custom headers.
- Documentation: Update README, GETTING_STARTED, or ROADMAP when behavior changes.
- Security: Never commit secrets or API keys. Use environment variables or example placeholders.

## Focus Areas We Especially Welcome

- Improvements to dynamic endpoint management
- New decentralized provider templates (io.net, Render, Vast.ai, etc.)
- Better Windows + WSL2 + Docker Desktop support
- Grafana dashboard enhancements and new panels
- Integration examples with agent frameworks (LangGraph, CrewAI, AutoGen)
- Cost tracking and optimization for decentralized nodes

## Questions?

Open an issue or start a discussion. We're building this for personal AI sovereignty — feedback from real users running their own clusters is extremely valuable.

Let's make decentralized, high-performance inference simple and reliable for everyone.