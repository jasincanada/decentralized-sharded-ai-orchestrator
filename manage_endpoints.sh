#!/bin/bash
#
# manage_endpoints.sh
# Reads endpoints/endpoints.txt and automatically rebuilds
# the Nginx upstream configuration, then reloads Nginx.
#
# Format of endpoints.txt (one per line):
#   http://192.168.1.50:8000   # Local Win11 3070 Ti
#   http://akash-node-xyz:8000 # Akash deployment
#   # http://io.net-node:8000  # commented out example
#

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"
NGINX_CONF="nginx/vllm-orchestrator.conf"
NGINX_UPSTREAM_CONF="nginx/upstream_vllm.conf"
NGINX_SITE_AVAILABLE="/etc/nginx/sites-available/vllm-orchestrator"
NGINX_SITE_ENABLED="/etc/nginx/sites-enabled/vllm-orchestrator"

echo "=== Managing vLLM Endpoints ==="

if [[ ! -f "$ENDPOINTS_FILE" ]]; then
    echo "Error: $ENDPOINTS_FILE not found!"
    echo "Create it with one backend URL per line."
    exit 1
fi

# Backup existing upstream if it exists
if [[ -f "$NGINX_UPSTREAM_CONF" ]]; then
    cp "$NGINX_UPSTREAM_CONF" "${NGINX_UPSTREAM_CONF}.bak"
fi

# Generate new upstream config
echo "upstream vllm_backends {" > "$NGINX_UPSTREAM_CONF"
echo "    least_conn;" >> "$NGINX_UPSTREAM_CONF"

# Read non-comment, non-empty lines
grep -v '^#' "$ENDPOINTS_FILE" | grep -v '^\s*$' | while read -r line; do
    # Extract URL (first word)
    url=$(echo "$line" | awk '{print $1}')
    if [[ -n "$url" ]]; then
        echo "    server $url;" >> "$NGINX_UPSTREAM_CONF"
        echo "    Added backend: $url"
    fi
done

echo "}" >> "$NGINX_UPSTREAM_CONF"

echo ""
echo "Generated new upstream configuration:"
cat "$NGINX_UPSTREAM_CONF"

# If running on a system with Nginx installed, copy and reload
if command -v nginx &> /dev/null; then
    echo ""
    echo "Copying to Nginx site and reloading..."
    sudo cp "$NGINX_CONF" "$NGINX_SITE_AVAILABLE" 2>/dev/null || true
    sudo cp "$NGINX_UPSTREAM_CONF" /etc/nginx/conf.d/ 2>/dev/null || true
    sudo nginx -t && sudo systemctl reload nginx
    echo "Nginx reloaded successfully."
else
    echo ""
    echo "Nginx not found on this system. Copy the generated config manually to your Nginx server."
    echo "Then run: nginx -t && systemctl reload nginx"
fi

echo ""
echo "Endpoint management complete."