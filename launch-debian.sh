#!/usr/bin/env bash
# launch-debian.sh
# Spin up a persistent Debian container using rootless Podman

set -euo pipefail

CONTAINER_NAME="claude-code-dev"
IMAGE="debian:bookworm-slim"

# Check if container already exists
if podman container exists "$CONTAINER_NAME" 2>/dev/null; then
  echo "Container '$CONTAINER_NAME' already exists. Starting it..."
  podman start "$CONTAINER_NAME"
else
  echo "Creating and starting container '$CONTAINER_NAME'..."
  podman run -dit \
    --name "$CONTAINER_NAME" \
    --userns=keep-id \
    -v "$HOME":"$HOME":z \
    -w "$HOME" \
    "$IMAGE" \
    bash
fi

echo ""
echo "Container is running. To enter it, run:"
echo "  podman exec -it $CONTAINER_NAME bash"
echo ""
echo "Or run the installer directly:"
echo "  podman exec -it $CONTAINER_NAME bash /path/to/install-claude-code.sh"
