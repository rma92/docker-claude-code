#!/usr/bin/env bash
# destroy.sh
# Stop and permanently remove the container.

set -euo pipefail

CONTAINER_NAME="${1:-claude-code-dev}"

if ! podman container exists "$CONTAINER_NAME" 2>/dev/null; then
  echo "Container '$CONTAINER_NAME' does not exist."
  exit 1
fi

read -rp "Destroy '$CONTAINER_NAME'? All container data will be lost. [y/N] " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }

podman stop "$CONTAINER_NAME" 2>/dev/null || true
podman rm "$CONTAINER_NAME"
echo "✓ Container '$CONTAINER_NAME' destroyed."
