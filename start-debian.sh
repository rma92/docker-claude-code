#!/usr/bin/env bash
# start.sh

set -euo pipefail

CONTAINER_NAME="${1:-claude-code-dev}"

if ! podman container exists "$CONTAINER_NAME" 2>/dev/null; then
  echo "Container '$CONTAINER_NAME' does not exist. Run launch-debian.sh first."
  exit 1
fi

podman start "$CONTAINER_NAME"
echo "✓ Container '$CONTAINER_NAME' started."
