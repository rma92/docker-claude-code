#!/usr/bin/env bash
# install-claude-code.sh
# Install Claude Code (user-mode, no root) inside a Debian container
# Run this inside the container: bash install-claude-code.sh

set -euo pipefail

echo "==> Updating apt and installing dependencies..."
apt-get update -qq
apt-get install -y --no-install-recommends \
  curl \
  tmux \
  ca-certificates \
  git \
  2>/dev/null

echo "==> Installing Claude Code via native installer..."
# The native installer installs to ~/.claude/local/ and updates ~/.bashrc / ~/.profile
curl -fsSL https://claude.ai/install.sh | bash

echo ""
echo "==> Claude Code installed. Sourcing profile to update PATH..."
# The installer appends to ~/.bashrc; source it to get 'claude' on PATH now
# shellcheck disable=SC1090
source "$HOME/.bashrc" 2>/dev/null || true

echo ""
echo "==> Verifying installation..."
if command -v claude &>/dev/null; then
  claude --version
  echo ""
  echo "✓ Claude Code is ready. Run 'claude' to start."
else
  # Fallback: installer puts binary here
  CLAUDE_BIN="$HOME/.claude/local/bin/claude"
  if [[ -x "$CLAUDE_BIN" ]]; then
    "$CLAUDE_BIN" --version
    echo ""
    echo "✓ Claude Code installed at $CLAUDE_BIN"
    echo "  Add to PATH permanently: echo 'export PATH=\"\$HOME/.claude/local/bin:\$PATH\"' >> ~/.bashrc"
  else
    echo "✗ Installation may have failed. Check output above."
    exit 1
  fi
fi
