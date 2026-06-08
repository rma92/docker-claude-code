#!/usr/bin/env bash
# install-codex.sh
# Install Codex CLI (root step) inside a Debian container
# Run this inside the container as root: bash install-codex.sh
# Then run install-codex-user.sh as the limited user.

set -euo pipefail

echo "==> Updating apt and installing dependencies..."
apt-get update -qq
apt-get install -y --no-install-recommends \
  gawk \
  curl \
  ca-certificates \
  2>/dev/null

echo ""
echo "==> Installing Codex CLI via native installer..."
curl -fsSL https://chatgpt.com/codex/install.sh | CODEX_NON_INTERACTIVE=1 sh

echo ""
echo "==> Codex CLI installed. Sourcing profile to update PATH..."
# shellcheck disable=SC1090
source "$HOME/.bashrc" 2>/dev/null || true

echo ""
echo "==> Verifying installation..."
if command -v codex &>/dev/null; then
  codex --version
  echo ""
  echo "✓ Codex is ready. Run 'codex' to start."
else
  CODEX_BIN="$HOME/.local/bin/codex"
  if [[ -x "$CODEX_BIN" ]]; then
    "$CODEX_BIN" --version
    echo ""
    echo "✓ Codex installed at $CODEX_BIN"
  else
    echo "✗ Installation may have failed. Check output above."
    exit 1
  fi
fi

echo ""
echo "==> Run install-codex-user.sh as the limited user to install Codex for that user."
