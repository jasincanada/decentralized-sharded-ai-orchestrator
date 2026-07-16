# Getting Started — decentralized-sharded-ai-orchestrator

One-page practical guide to get your sharded vLLM cluster running.

## 1. Ubuntu Server 25 Quick Setup (Recommended First Node)

```bash
# On a fresh Ubuntu 25.04 server with NVIDIA GPU
wget https://raw.githubusercontent.com/jasincanada/decentralized-sharded-ai-orchestrator/main/setup_orchestrator.sh
chmod +x setup_orchestrator.sh
sudo ./setup_orchestrator.sh
```

The script will:
- Update system & install Docker + NVIDIA Container Toolkit
- Create directory structure
- Start vLLM service (Qwen2.5-Coder-32B or similar, tensor-parallel-size auto-detected)
- Print next steps

Edit `endpoints/endpoints.txt` and run `manage_endpoints.sh` to register the node.

## 2. Adding Your Windows 11 + RTX 3070 Ti Node

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) on Windows 11
2. Enable WSL2 backend + NVIDIA GPU support in Docker Desktop settings
3. Run the PowerShell script:

```powershell
# In PowerShell as Administrator
cd win11-setup
.\setup.ps1
```

This installs vLLM in a Docker container with your 3070 Ti, exposes port 8000, and prepares it for the orchestrator.

Add the node IP:8000 to `endpoints/endpoints.txt` on your main orchestrator.

## 3. Adding Decentralized Nodes (Akash, io.net, etc.)

### Akash Example
```bash
# Deploy using the provided SDL
akash tx deployment create decentralized-deploy/akash-vllm.yaml --from yourkey --node ...
```

Update `endpoints/endpoints.txt` with the public endpoint + API key if required.

### io.net / Other Providers
Add the provider's vLLM-compatible endpoint URL and any required headers to `endpoints/endpoints.txt`.

## 4. Connecting to Continue.dev

In Continue.dev `config.json` or `config.yaml`:

```json
{
  "models": [
    {
      "title": "Sharded Orchestrator (Qwen)",
      "provider": "openai",
      "model": "Qwen/Qwen2.5-Coder-32B-Instruct",
      "apiBase": "http://your-orchestrator-ip:80/v1",
      "apiKey": "not-needed-for-local"
    }
  ]
}
```

Point Continue.dev at your Nginx orchestrator for automatic load balancing across all backends.

## 5. Daily Workflow

1. Add/remove nodes by editing `endpoints/endpoints.txt`
2. Run `./manage_endpoints.sh` to instantly update Nginx upstreams
3. Check Grafana dashboard for health, throughput, and per-node GPU usage
4. Monitor Prometheus alerts for node failures or high latency
5. Scale by adding more Akash deployments or local GPUs

## Recommended Models

- **Primary**: Qwen2.5-Coder-32B-Instruct or Qwen3 (when available) — excellent for coding/agentic work
- **Fallback**: Smaller quantized models on resource-constrained nodes
- **Tensor Parallel**: Automatically enabled on multi-GPU or high-memory nodes

## Next Steps

- Read [ROADMAP.md](ROADMAP.md) for planned features
- Customize `nginx/vllm-orchestrator.conf` for auth / rate limiting
- Add your own monitoring alerts in Prometheus
- Integrate with your personal RAG / agentic stack

You're now running a decentralized, sharded, observable AI inference cluster. Welcome to the future of personal compute sovereignty.