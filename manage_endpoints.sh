#!/bin/bash
#
# manage_endpoints.sh
# Reads endpoints/endpoints.txt and automatically rebuilds
# the Nginx upstream configuration, then reloads Nginx.
#
# Now includes optional integration with the routing layer.

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"
NGINX_CONF="nginx/vllm-orchestrator.conf"
NGINX_UPSTREAM_CONF="nginx/upstream_vllm.conf"

ROUTER_SCRIPT="routing/simple-router.py"

function check_health {
    echo "=== Health Check Mode ==="
    grep -v '^#' "$ENDPOINTS_FILE" | grep -v '^\s*$' | while read -r line; do
        url=$(echo "$line" | awk '{print $1}')
        if [[ -n "$url" ]]; then
            if curl -s --max-time 5 "$url/health" > /dev/null 2>&1; then
                echo "[OK]   $url"
            else
                echo "[FAIL] $url"
            fi
        fi
    done
}

if [[ "${1:-}" == "--health-check" || "${1:-}" == "-c" ]]; then
    check_health
    exit 0
fi

# Optional: Use router to suggest best backend (future integration point)
if [[ "${1:-}" == "--suggest" ]]; then
    if [[ -f "$ROUTER_SCRIPT" ]]; then
        echo "Suggested best backend:"
        python3 "$ROUTER_SCRIPT" --best-for balanced
    else
        echo "Router not found."
    fi
    exit 0
fi

echo "=== Managing vLLM Endpoints ==="

if [[ ! -f "$ENDPOINTS_FILE" ]]; then
    echo "Error: $ENDPOINTS_FILE not found!"
    exit 1
fi

if [[ -f "$NGINX_UPSTREAM_CONF" ]]; then
    cp "$NGINX_UPSTREAM_CONF" "${NGINX_UPSTREAM_CONF}.bak"
fi

echo "upstream vllm_backends {" > "$NGINX_UPSTREAM_CONF"
echo "    least_conn;" >> "$NGINX_UPSTREAM_CONF"

grep -v '^#' "$ENDPOINTS_FILE" | grep -v '^\s*$' | while read -r line; do
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

if command -v nginx &> /dev/null; then
    sudo cp "$NGINX_CONF" /etc/nginx/sites-available/vllm-orchestrator 2>/dev/null || true
    sudo cp "$NGINX_UPSTREAM_CONF" /etc/nginx/conf.d/ 2>/dev/null || true
    sudo nginx -t && sudo systemctl reload nginx
    echo "Nginx reloaded successfully."
else
    echo "Nginx not found on this system."
fi

echo ""
echo "Endpoint management complete."
echo "Tip: Use --health-check or --suggest for advanced features."