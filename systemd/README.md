# systemd Service Examples

Place these files in `/etc/systemd/system/` and enable them for automatic startup.

## vLLM Service

```bash
sudo cp systemd/vllm.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now vllm.service
```

## Orchestrator Notes

The main orchestration is handled by Nginx + `manage_endpoints.sh`. 
You can create a simple timer or service that runs `manage_endpoints.sh` on boot if desired.

Adjust paths and users as needed for your environment.