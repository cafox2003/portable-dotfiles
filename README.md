## Dotfiles Setup

This repository contains my portable dotfiles for **nvim**, **fish**, and **tmux**. The repo lives in `~/.config`, and `tmux.conf` is symlinked to the home directory.

### Installation

You can set up a new system by running the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/cafox2003/portable-dotfiles/main/bootstrap.sh | bash
```

This script will:

1. Clone the repository into `~/.config` (if it doesn't already exist).  
2. Symlink `~/.tmux.conf` to the version in the repo.  
3. Set fish as your default shell (if installed).  
4. Print instructions for installing required packages on your system.

> **Note:** The script does **not automatically install packages**. Please install them manually using the commands below, depending on your OS:

```bash
# Debian / Ubuntu
sudo apt update && sudo apt install git fish tmux neovim

# Fedora
sudo dnf install git fish tmux neovim

# Arch
sudo pacman -Syu git fish tmux neovim

# macOS (Homebrew)
brew install git fish tmux neovim
```

---

### Gitignore

This repository uses a whitelist-style `.gitignore` to track only the necessary config files:

```gitignore
# Ignore everything by default
*

# Track the gitignore itself
!.gitignore

# Whitelist main directories
!nvim/
!fish/

# Include everything inside these directories
!nvim/**
!fish/**

# Track tmux symlink (at top level of repo)
!tmux.conf

# Optional: Ignore swap, temp, or backup files
*.swp
*.swo
*.tmp
*.bak
```

