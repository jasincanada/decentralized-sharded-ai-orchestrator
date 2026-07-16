# Roadmap — decentralized-sharded-ai-orchestrator

## Short Term (Next 1–3 Months)

- **Core Stability & Polish**
  - Add basic authentication (API key or basic auth) to Nginx
  - Implement simple health check + automatic node removal on failure
  - Improve `manage_endpoints.sh` with validation and dry-run mode
  - Add systemd service files for easier management on Ubuntu
  - Expand Grafana dashboard with token throughput, error rates, and cost metrics (for decentralized nodes)

- **Windows & Consumer GPU Improvements**
  - Better WSL2 + Docker Desktop integration testing
  - Support for multiple local GPUs on one Windows machine
  - Automated firewall / port forwarding helpers

- **Documentation & Onboarding**
  - Video walkthrough (Ubuntu + Win11 setup)
  - More example `endpoints.txt` configurations
  - Troubleshooting guide for common vLLM + Nginx issues

## Medium Term (3–6 Months)

- **Intelligent Orchestration Layer**
  - Lightweight Python/FastAPI router that:
    - Performs model-aware routing
    - Implements load-aware / cost-aware dispatching
    - Supports fallback chains and circuit breakers
  - Integration with LangGraph / DSPy agents for automatic backend selection

- **Advanced Monitoring & Alerting**
  - Prometheus alert rules for high latency, GPU OOM, node offline
  - Grafana alerts + Slack/Telegram notifications
  - Per-model usage tracking and cost dashboards

- **Decentralized Provider Expansions**
  - Official io.net deployment template
  - Support for other Akash-compatible providers
  - Automatic endpoint discovery scripts (where APIs allow)

- **Security Hardening**
  - Cloudflare Tunnel / Tailscale integration examples
  - Rate limiting and abuse protection
  - Secrets management (SOPS or similar)

## Long Term (6–12+ Months)

- **Full Agentic Platform Integration**
  - Native support for personal AI Oracle / RAG systems
  - One-click deployment of sharded inference clusters for specific agent workflows
  - Multi-model ensemble routing (coding model + generalist + tool-calling model)

- **Self-Healing & Auto-Scaling**
  - Kubernetes operator or Nomad integration for dynamic node scaling
  - Automatic Akash deployment scaling based on queue depth / latency
  - Predictive node provisioning based on usage patterns

- **Community & Ecosystem**
  - Public template marketplace for common model configurations
  - Shared Grafana dashboard gallery
  - Partnership / compatibility with major decentralized compute networks

- **Research & Optimization**
  - Continuous batching improvements and custom vLLM patches
  - Quantization strategy automation across heterogeneous hardware
  - Energy efficiency and carbon-aware routing research

## Guiding Principles

- Keep operational complexity low for solo operators
- Prioritize local + decentralized sovereignty over pure cloud convenience
- Make high-performance sharded inference accessible to individuals with consumer + decentralized hardware
- Build in public with clear documentation and reproducible setups

Contributions and feedback on any part of the roadmap are highly welcome.