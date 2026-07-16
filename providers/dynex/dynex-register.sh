#!/bin/bash
#
# dynex-register.sh
# Helper script to add and test Dynex nodes.
#
# Usage:
#   ./providers/dynex/dynex-register.sh add http://your-dynex-endpoint:8000 "Dynex Node" 0.10
#   ./providers/dynex/dynex-register.sh test http://your-dynex-endpoint:8000

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"

function add_node() {
    local url="$1"
    local name="$2"
    local cost="$3"

    echo "Adding Dynex node: $url (name=$name, cost=$cost)"
    echo "$url   # provider=dynex, name=$name, cost=$cost" >> "$ENDPOINTS_FILE"
    echo "Node added. Run manage_endpoints.sh to update Nginx."
}

function test_node() {
    local url="$1"
    echo "Testing Dynex node: $url"

    if curl -s --max-time 8 "$url/health" > /dev/null 2>&1; then
        echo "[OK] Health check passed"
    else
        echo "[FAIL] Health check failed"
        exit 1
    fi

    if curl -s --max-time 8 "$url/v1/models" | grep -q "id"; then
        echo "[OK] Appears to be vLLM-compatible"
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
        exit 1
        ;;
esac
