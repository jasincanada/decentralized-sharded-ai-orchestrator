#!/bin/bash
#
# setup_orchestrator.sh
# Robust one-command setup for Ubuntu Server 25.04 (or recent Ubuntu)
# Installs Docker, NVIDIA Container Toolkit, creates directories,
# and prepares the vLLM service for the decentralized orchestrator.
#
# Usage: sudo ./setup_orchestrator.sh
#

set -euo pipefail

echo "=== decentralized-sharded-ai-orchestrator Setup ==="
echo "Starting system preparation for Ubuntu Server..."

# 1. Update system
echo "[1/6] Updating system packages..."
apt-get update -y
apt-get upgrade -y

# 2. Install prerequisites
echo "[2/6] Installing prerequisites (curl, ca-certificates, etc.)..."
apt-get install -y curl ca-certificates gnupg lsb-release

# 3. Install Docker
echo "[3/6] Installing Docker..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com | sh
    systemctl enable --now docker
else
    echo "Docker already installed. Skipping."
fi

# 4. Install NVIDIA Container Toolkit
echo "[4/6] Installing NVIDIA Container Toolkit..."
if ! command -v nvidia-container-cli &> /dev/null; then
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | \
        gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
    curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    apt-get update
    apt-get install -y nvidia-container-toolkit
    nvidia-ctk runtime configure --runtime=docker
    systemctl restart docker
else
    echo "NVIDIA Container Toolkit already installed. Skipping."
fi

# 5. Create project directory structure
echo "[5/6] Creating project directories..."
mkdir -p /opt/decentralized-sharded-ai-orchestrator/{nginx,endpoints,prometheus,grafana/provisioning/datasources,grafana/dashboards,decentralized-deploy,win11-setup,.github/workflows}
chown -R $SUDO_USER:$SUDO_USER /opt/decentralized-sharded-ai-orchestrator 2>/dev/null || true

# 6. Create example vLLM docker-compose or systemd note
echo "[6/6] Preparing vLLM service example..."
cat > /opt/decentralized-sharded-ai-orchestrator/docker-compose.vllm.yml << 'EOF'
version: '3.8'
services:
  vllm:
    image: vllm/vllm-openai:latest
    container_name: vllm-local
    runtime: nvidia
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
    volumes:
      - /models:/models
    ports:
      - "8000:8000"
    command: >
      --model Qwen/Qwen2.5-Coder-32B-Instruct
      --tensor-parallel-size 1
      --max-model-len 32768
      --gpu-memory-utilization 0.9
      --host 0.0.0.0
      --port 8000
    restart: unless-stopped
EOF

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "1. Place your model weights in /models (or use Hugging Face cache)"
echo "2. Start vLLM: docker compose -f /opt/decentralized-sharded-ai-orchestrator/docker-compose.vllm.yml up -d"
echo "3. Edit /opt/decentralized-sharded-ai-orchestrator/endpoints/endpoints.txt with your node(s)"
echo "4. Run manage_endpoints.sh to configure Nginx"
echo "5. Start Prometheus + Grafana (see README or GETTING_STARTED)"
echo ""
echo "For full instructions, see GETTING_STARTED.md"
echo "Happy orchestrating!"