#!/bin/bash
#
# manage_endpoints.sh
# Core endpoint management with optional intelligent routing integration.

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"
NGINX_CONF="nginx/vllm-orchestrator.conf"
NGINX_UPSTREAM_CONF="nginx/upstream_vllm.conf"
ROUTER="routing/simple-router.py"

function suggest_best() {
    if [[ -f "$ROUTER" ]]; then
        echo "=== Intelligent Suggestion from Router ==="
        python3 "$ROUTER" --best-for balanced --json 2>/dev/null || python3 "$ROUTER" --best-for balanced
    else
        echo "Router not available."
    fi
}

function check_health() {
    echo "=== Health Check ==="
    grep -v '^#' "$ENDPOINTS_FILE" | grep -v '^\s*$' | while read -r line; do
        url=$(echo "$line" | awk '{print $1}')
        [[ -z "$url" ]] && continue
        if curl -s --max-time 5 "$url/health" >/dev/null 2>&1; then
            echo "[OK]  $url"
        else
            echo "[FAIL] $url"
        fi
    done
}

if [[ "${1:-}" == "--suggest" ]]; then
    suggest_best
    exit 0
fi

if [[ "${1:-}" == "--health-check" || "${1:-}" == "-c" ]]; then
    check_health
    exit 0
fi

echo "=== Managing vLLM Endpoints ==="

if [[ ! -f "$ENDPOINTS_FILE" ]]; then
    echo "Error: endpoints file not found"
    exit 1
fi

if [[ -f "$NGINX_UPSTREAM_CONF" ]]; then
    cp "$NGINX_UPSTREAM_CONF" "${NGINX_UPSTREAM_CONF}.bak"
fi

echo "upstream vllm_backends {" > "$NGINX_UPSTREAM_CONF"
echo "    least_conn;" >> "$NGINX_UPSTREAM_CONF"

grep -v '^#' "$ENDPOINTS_FILE" | grep -v '^\s*$' | while read -r line; do
    url=$(echo "$line" | awk '{print $1}')
    [[ -n "$url" ]] && echo "    server $url;" >> "$NGINX_UPSTREAM_CONF"
done

echo "}" >> "$NGINX_UPSTREAM_CONF"

echo "Generated upstream config."

if command -v nginx &> /dev/null; then
    sudo cp "$NGINX_CONF" /etc/nginx/sites-available/vllm-orchestrator 2>/dev/null || true
    sudo cp "$NGINX_UPSTREAM_CONF" /etc/nginx/conf.d/ 2>/dev/null || true
    sudo nginx -t && sudo systemctl reload nginx && echo "Nginx reloaded."
fi

echo "Done. Use --suggest or --health-check for advanced features."