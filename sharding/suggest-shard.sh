#!/bin/bash
#
# suggest-shard.sh
# Mature helper for sharding / tensor-parallel node selection.
#
# Features:
# - Suggest nodes for a given tensor-parallel size
# - JSON output
# - Show total available GPU capacity
# - Recommend configuration hints

set -euo pipefail

ENDPOINTS_FILE="endpoints/endpoints.txt"
MIN_GPUS=${1:-2}
JSON_MODE=false

if [[ "${2:-}" == "--json" ]]; then
    JSON_MODE=true
fi

TOTAL_GPUS=0
NODES=()

while IFS= read -r line; do
    line=$(echo "$line" | xargs)
    [[ -z "$line" || "$line" == "#"* ]] && continue

    url=$(echo "$line" | awk '{print $1}')
    comment=$(echo "$line" | cut -d'#' -f2- | xargs)

    gpus=$(echo "$comment" | grep -o 'gpus=[0-9]*' | cut -d= -f2 || echo "1")

    if [[ "$gpus" -ge "$MIN_GPUS" ]]; then
        NODES+=("$url|$gpus")
        TOTAL_GPUS=$((TOTAL_GPUS + gpus))
    fi
done < "$ENDPOINTS_FILE"

if [[ ${#NODES[@]} -eq 0 ]]; then
    echo "No nodes found with >= $MIN_GPUS GPUs."
    exit 0
fi

if $JSON_MODE; then
    echo "["
    for i in "${!NODES[@]}"; do
        node="${NODES[$i]}"
        url=$(echo "$node" | cut -d'|' -f1)
        gpus=$(echo "$node" | cut -d'|' -f2 | cut -d= -f2)
        comma=","
        [[ $i -eq $((${#NODES[@]} - 1)) ]] && comma=""
        echo "  {\"url\": \"$url\", \"gpus\": $gpus}$comma"
    done
    echo "]"
else
    echo "=== Nodes suitable for tensor-parallel-size >= $MIN_GPUS ==="
    for node in "${NODES[@]}"; do
        url=$(echo "$node" | cut -d'|' -f1)
        gpus=$(echo "$node" | cut -d'|' -f2 | cut -d= -f2)
        echo "  $url (gpus=$gpus)"
    done

    echo ""
    echo "Total available GPUs across suitable nodes: $TOTAL_GPUS"
    echo "Recommended vLLM flag: --tensor-parallel-size $MIN_GPUS"
    echo "Tip: Combine with routing for best node selection."
fi