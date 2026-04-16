#!/usr/bin/env bash
# install-gh.sh
# Install GitHub CLI (gh) inside a Debian container — no prompts

set -euo pipefail

echo "==> Installing GitHub CLI..."
apt-get update -qq
apt-get install -y --no-install-recommends curl ca-certificates

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" \
  | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

apt-get update -qq
apt-get install -y --no-install-recommends gh

echo ""
echo "==> Verifying installation..."
gh --version
echo ""
echo "✓ gh is ready. Run 'gh auth login' to authenticate."
