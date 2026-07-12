#!/usr/bin/env bash
set -euo pipefail

trap 'echo "❌ Error on line $LINENO: $BASH_COMMAND"' ERR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "▶ Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y \
    curl \
    git \
    ca-certificates \
    build-essential

echo "▶ Removing Ubuntu-packaged Node.js..."
sudo apt-get remove -y nodejs npm libnode72 libnode-dev || true
sudo apt-get autoremove -y || true

export NVM_DIR="$HOME/.nvm"

echo "▶ Removing any previous nvm installation..."
rm -rf "$NVM_DIR"

echo "▶ Installing nvm..."

curl -4 -fsSL \
    https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh \
    -o /tmp/install-nvm.sh

chmod +x /tmp/install-nvm.sh
bash /tmp/install-nvm.sh

echo "▶ Loading nvm..."

if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    echo "❌ nvm installation failed."
    exit 1
fi

# nvm is not compatible with `set -u`, so temporarily disable nounset if enabled.
set +u

# shellcheck source=/dev/null
source "$NVM_DIR/nvm.sh"

echo "▶ Installing latest Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

set -u 2>/dev/null || true

hash -r

echo "▶ Verifying Node installation..."

command -v node
command -v npm

NODE_VERSION="$(node --version)"
NPM_VERSION="$(npm --version)"

echo "Node: $NODE_VERSION"
echo "npm : $NPM_VERSION"

echo "▶ Enabling Corepack..."
corepack enable
corepack prepare yarn@stable --activate

hash -r

command -v yarn
YARN_VERSION="$(yarn --version)"

echo "Yarn: $YARN_VERSION"

echo "▶ Installing global JavaScript packages..."

if [[ -f "$SCRIPT_DIR/install_global_javascript_npm_packages.sh" ]]; then
    # shellcheck source=/dev/null
    source "$SCRIPT_DIR/install_global_javascript_npm_packages.sh"
fi

echo "▶ Persisting nvm configuration..."

grep -q 'NVM_DIR="$HOME/.nvm"' "$HOME/.bashrc" 2>/dev/null || cat >> "$HOME/.bashrc" <<'EOF'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
EOF

if [[ -f "$HOME/.profile" ]]; then
    grep -q 'NVM_DIR="$HOME/.nvm"' "$HOME/.profile" 2>/dev/null || cat >> "$HOME/.profile" <<'EOF'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
EOF
fi

echo
echo "======================================"
echo "✅ Node.js installation completed"
echo "======================================"
echo "Node : $(node --version)"
echo "npm  : $(npm --version)"
echo "Yarn : $(yarn --version)"
echo "nvm  : $(nvm --version)"
echo
echo "Open a new terminal (or run 'source ~/.bashrc') to use nvm in future shells."