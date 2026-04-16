#!/usr/bin/env bash
# mount-home.sh
# Add the host $HOME as a volume mount to an existing container.
# Podman doesn't support live mounts, so this recreates the container preserving its image.

set -euo pipefail

CONTAINER_NAME="${1:-claude-code-dev}"

IMAGE=$(podman inspect --format '{{.ImageName}}' "$CONTAINER_NAME")

echo "Stopping '$CONTAINER_NAME'..."
podman stop "$CONTAINER_NAME" 2>/dev/null || true

echo "Recreating with host \$HOME mounted..."
podman rm "$CONTAINER_NAME"
podman run -dit \
  --name "$CONTAINER_NAME" \
  --userns=keep-id \
  -v "$HOME":"$HOME":z \
  -w "$HOME" \
  "$IMAGE" \
  bash

echo "✓ Host \$HOME is now mounted at $HOME inside the container."
