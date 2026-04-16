#!/usr/bin/env bash
# stop.sh

set -euo pipefail

CONTAINER_NAME="${1:-claude-code-dev}"
podman stop "$CONTAINER_NAME"
echo "Container '$CONTAINER_NAME' stopped."
