#!/usr/bin/env bash
# enter.sh — drop into the running container
CONTAINER_NAME="claude-code-dev"
podman exec -it "$CONTAINER_NAME" bash --login
