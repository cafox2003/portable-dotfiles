#!/usr/bin/env bash
# bootstrap.sh - Set up dotfiles from https://github.com/cafox2003/portable-dotfiles
# Usage: curl -fsSL https://raw.githubusercontent.com/cafox2003/portable-dotfiles/main/bootstrap.sh | bash

set -euo pipefail

REPO_URL="https://github.com/cafox2003/portable-dotfiles"
CONFIG_DIR="$HOME/.config"
TMUX_CONF="$HOME/.tmux.conf"
FISH_SHELL=$(which fish || echo "/usr/bin/fish")

echo "🚀 Starting dotfiles setup..."

# install nvim binary

# Download latest Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
sudo mv nvim-linux-x86_64 /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz


# --- Step 0: Preliminary checks ---
if ! command -v git &> /dev/null; then
    echo "⚠️ Git is not installed. Please install git first."
    exit 1
fi

# Check if .config is already a git repo
if [ -d "$CONFIG_DIR/.git" ]; then
    echo "Repo already exists. Pulling latest changes..."
    git -C "$CONFIG_DIR" pull
else
    if [ -d "$CONFIG_DIR" ]; then
        echo "Directory $CONFIG_DIR exists and is not empty. Forcing clone..."
        # Temporary move existing files
        TEMP_BACKUP="$CONFIG_DIR-backup-$(date +%s)"
        mv "$CONFIG_DIR" "$TEMP_BACKUP"
        echo "Backed up existing .config to $TEMP_BACKUP"
    fi

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

