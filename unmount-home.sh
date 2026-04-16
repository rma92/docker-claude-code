#!/usr/bin/env bash
# unmount-home.sh
# Recreate the container without the host $HOME mount.

set -euo pipefail

CONTAINER_NAME="${1:-claude-code-dev}"

IMAGE=$(podman inspect --format '{{.ImageName}}' "$CONTAINER_NAME")

echo "Stopping '$CONTAINER_NAME'..."
podman stop "$CONTAINER_NAME" 2>/dev/null || true

echo "Recreating without host \$HOME mount..."
podman rm "$CONTAINER_NAME"
podman run -dit \
  --name "$CONTAINER_NAME" \
  --userns=keep-id \
  "$IMAGE" \
  bash

echo "✓ Host \$HOME is no longer mounted. Container has an isolated filesystem."
