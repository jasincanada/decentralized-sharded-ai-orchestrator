#!/bin/bash
#
# suggest-shard.sh
# Basic helper to suggest node groups for tensor-parallel sharding.
#
# Usage:
#   ./sharding/suggest-shard.sh 2   # Suggest nodes for tensor-parallel-size=2

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"
MIN_GPUS=${1:-2}

echo "=== Suggested nodes for tensor-parallel-size >= $MIN_GPUS ==="

grep -v '^#' "$ENDPOINTS_FILE" | grep -v '^\s*$' | while read -r line; do
    url=$(echo "$line" | awk '{print $1}')
    comment=$(echo "$line" | cut -d'#' -f2- | xargs)

    gpus=$(echo "$comment" | grep -o 'gpus=[0-9]*' | cut -d= -f2 || echo 1)

    if [[ "$gpus" -ge "$MIN_GPUS" ]]; then
        echo "$url (gpus=$gpus)"
    fi
done

echo ""
echo "Tip: Use these nodes when running vLLM with --tensor-parallel-size $MIN_GPUS"