#!/bin/bash
#
# aioz-register.sh
# Helper script to add and test AIOZ nodes in the orchestrator.
#
# Usage:
#   ./providers/aioz/aioz-register.sh add http://your-aioz-endpoint:8000 "My AIOZ Node" 0.12
#   ./providers/aioz/aioz-register.sh test http://your-aioz-endpoint:8000

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"

add_node() {
    local url="$1"
    local name="$2"
    local cost="$3"

    echo "Adding AIOZ node: $url (name=$name, cost=$cost)"

    # Append to endpoints.txt with AIOZ metadata
    echo "$url   # provider=aioz, name=$name, cost=$cost" >> "$ENDPOINTS_FILE"

    echo "Node added. Run manage_endpoints.sh to update Nginx."
}

test_node() {
    local url="$1"
    echo "Testing AIOZ node: $url"

    if curl -s --max-time 8 "$url/health" > /dev/null 2>&1; then
        echo "[OK] Health check passed"
    else
        echo "[FAIL] Health check failed or endpoint unreachable"
        exit 1
    fi

    # Optional: Try to list models if it's a vLLM-compatible endpoint
    if curl -s --max-time 8 "$url/v1/models" | grep -q "id"; then
        echo "[OK] Appears to be a vLLM-compatible endpoint"
    else
        echo "[WARN] Could not confirm vLLM compatibility"
    fi
}

case "${1:-}" in
    add)
        if [[ $# -lt 4 ]]; then
            echo "Usage: $0 add <url> <name> <cost>"
            exit 1
        fi
        add_node "$2" "$3" "$4"
        ;;
    test)
        if [[ $# -lt 2 ]]; then
            echo "Usage: $0 test <url>"
            exit 1
        fi
        test_node "$2"
        ;;
    *)
        echo "Usage: $0 {add|test} ..."
        echo "  add <url> <name> <cost>"
        echo "  test <url>"
        exit 1
        ;;
esac
