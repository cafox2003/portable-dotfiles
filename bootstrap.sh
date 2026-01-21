#!/usr/bin/env bash
# bootstrap.sh - Set up dotfiles from https://github.com/cafox2003/portable-dotfiles
# Usage: curl -fsSL https://raw.githubusercontent.com/cafox2003/portable-dotfiles/main/bootstrap.sh | bash

set -euo pipefail

REPO_URL="https://github.com/cafox2003/portable-dotfiles"
CONFIG_DIR="$HOME/.config"
TMUX_CONF="$HOME/.tmux.conf"
FISH_SHELL=$(which fish || echo "/usr/bin/fish")

echo "🚀 Starting dotfiles setup..."

# --- Step 0: Preliminary checks ---
if ! command -v git &> /dev/null; then
    echo "⚠️ Git is not installed. Please install git first."
    exit 1
fi

# --- Step 1: Clone the dotfiles repo ---
if [ -d "$CONFIG_DIR" ]; then
    echo "⚠️ $CONFIG_DIR already exists. Skipping clone..."
else
    echo "Cloning dotfiles into $CONFIG_DIR..."
    git clone "$REPO_URL" "$CONFIG_DIR"
fi

# --- Step 2: Symlink tmux config ---
if [ -e "$TMUX_CONF" ] && [ ! -L "$TMUX_CONF" ]; then
    echo "⚠️ $TMUX_CONF already exists and is not a symlink. Backing it up..."
    mv "$TMUX_CONF" "$TMUX_CONF.bak"
fi

ln -sf "$CONFIG_DIR/tmux.conf" "$TMUX_CONF"
echo "Linked tmux config: $TMUX_CONF -> $CONFIG_DIR/tmux.conf"

# --- Step 3: Set fish as default shell ---
if ! grep -Fxq "$FISH_SHELL" /etc/shells 2>/dev/null; then
    echo "⚠️ Fish shell ($FISH_SHELL) not found in /etc/shells. You may need to add it manually."
else
    if [ "$SHELL" != "$FISH_SHELL" ]; then
        echo "Changing default shell to fish..."
        chsh -s "$FISH_SHELL"
    else
        echo "Fish is already the default shell."
    fi
fi

