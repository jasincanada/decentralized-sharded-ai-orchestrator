#!/bin/bash
#
# suggest-shard.sh
# Enhanced helper for suggesting sharding configurations.
#
# Usage:
#   ./sharding/suggest-shard.sh 2
#   ./sharding/suggest-shard.sh 4 --json

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"
MIN_GPUS=${1:-2}
JSON_MODE=false

if [[ "${2:-}" == "--json" ]]; then
    JSON_MODE=true
fi

NODES=()

while IFS= read -r line; do
    line=$(echo "$line" | xargs)
    [[ -z "$line" || "$line" == "#"* ]] && continue

    url=$(echo "$line" | awk '{print $1}')
    comment=$(echo "$line" | cut -d'#' -f2- | xargs)

    gpus=$(echo "$comment" | grep -o 'gpus=[0-9]*' | cut -d= -f2 || echo "1")

    if [[ "$gpus" -ge "$MIN_GPUS" ]]; then
        NODES+=("$url|gpus=$gpus")
    fi
done < "$ENDPOINTS_FILE"

if [[ ${#NODES[@]} -eq 0 ]]; then
    echo "No nodes with >= $MIN_GPUS GPUs found."
    exit 0
fi

if $JSON_MODE; then
    echo "["
    for i in "${!NODES[@]}"; do
        node="${NODES[$i]}"
        url=$(echo "$node" | cut -d'|' -f1)
        gpus=$(echo "$node" | cut -d'=' -f2)
        comma=","
        [[ $i -eq $((${#NODES[@]} - 1)) ]] && comma=""
        echo "  {\"url\": \"$url\", \"gpus\": $gpus}$comma"
    done
    echo "]"
else
    echo "=== Recommended nodes for tensor-parallel-size >= $MIN_GPUS ==="
    for node in "${NODES[@]}"; do
        echo "  $(echo "$node" | cut -d'|' -f1) (gpus=$(echo "$node" | cut -d'=' -f2))"
    done
    echo ""
    echo "Use with: vllm ... --tensor-parallel-size $MIN_GPUS"
fi