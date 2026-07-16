# win11-setup/setup.ps1
# PowerShell script for Windows 11 + Docker Desktop + RTX 3070 Ti
# Runs vLLM in a container and exposes it for the orchestrator.
#
# Run in PowerShell as Administrator after installing Docker Desktop
# with WSL2 backend and NVIDIA GPU support enabled.

Write-Host "=== Windows 11 + RTX 3070 Ti vLLM Setup ===" -ForegroundColor Cyan

# Check Docker
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker Desktop not found. Please install it first."
    exit 1
}

# Check for NVIDIA GPU support in Docker
Write-Host "[0/5] Checking NVIDIA GPU support in Docker..."
try {
    docker info | Select-String "nvidia" | Out-Null
    Write-Host "NVIDIA GPU support detected in Docker." -ForegroundColor Green
} catch {
    Write-Warning "NVIDIA GPU support not detected in Docker. Please enable it in Docker Desktop settings > Resources > WSL Integration."
}

# Pull latest vLLM image
Write-Host "[1/5] Pulling vLLM Docker image..."
docker pull vllm/vllm-openai:latest

# Create models directory if it doesn't exist
$modelsPath = "$env:USERPROFILE\models"
if (-not (Test-Path $modelsPath)) {
    New-Item -ItemType Directory -Path $modelsPath | Out-Null
    Write-Host "Created $modelsPath — place your model weights here or let vLLM download from Hugging Face."
}

# Run vLLM container
Write-Host "[2/5] Starting vLLM container on port 8000..."
docker run -d `
    --name vllm-3070ti `
    --gpus all `
    -p 8000:8000 `
    -v "${modelsPath}:/models" `
    vllm/vllm-openai:latest `
    --model Qwen/Qwen2.5-Coder-32B-Instruct `
    --tensor-parallel-size 1 `
    --max-model-len 32768 `
    --gpu-memory-utilization 0.9 `
    --host 0.0.0.0 `
    --port 8000

Write-Host "[3/5] Waiting for vLLM to become ready (this can take several minutes on first run)..."
Start-Sleep -Seconds 30

# Test endpoint
Write-Host "[4/5] Testing local endpoint..."
try {
    $response = Invoke-RestMethod -Uri "http://localhost:8000/v1/models" -Method GET -TimeoutSec 10
    Write-Host "Success! vLLM is running." -ForegroundColor Green
    Write-Host "Available models: $($response.data.id)"
} catch {
    Write-Warning "vLLM may still be loading the model. Check logs with: docker logs -f vllm-3070ti"
}

Write-Host "[5/5] Final notes..."
Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host "Your 3070 Ti node is now available at http://YOUR-WIN11-IP:8000"
Write-Host "Add this address to endpoints/endpoints.txt on your orchestrator server."
Write-Host "Then run manage_endpoints.sh to include it in the load balancer."
Write-Host ""
Write-Host "Firewall note: You may need to allow port 8000 through Windows Firewall for remote access."
Write-Host "To stop: docker stop vllm-3070ti"
Write-Host "To view logs: docker logs -f vllm-3070ti"
Write-Host "For multi-GPU setups, adjust --gpus flag or use specific GPU IDs."