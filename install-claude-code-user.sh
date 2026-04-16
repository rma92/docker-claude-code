#!/usr/bin/env bash
# install-claude-code-user.sh
# Install Claude Code (user-mode, no root) inside a Debian container
# Run this inside the container as a limited user after installing as root or running the apt command from install-claude-code.sh : bash install-claude-code-user.sh

set -euo pipefail

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
    #echo "  Add to PATH permanently: echo 'export PATH=\"\$HOME/.claude/local/bin:\$PATH\"' >> ~/.bashrc"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
  else
    echo "✗ Installation may have failed. Check output above."
    exit 1
  fi
fi
