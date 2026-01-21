## Dotfiles Setup

This repository contains my portable dotfiles for **nvim**, **fish**, and **tmux**. The repo lives in `~/.config`, and `tmux.conf` is symlinked to the home directory.

### Installation

The script does **not automatically install packages**. Please install them manually using the commands below, depending on your OS
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

You can set up a new system by running the following command:

```bash
curl -fsSL https://raw.githubusercontent.com/cafox2003/portable-dotfiles/main/bootstrap.sh | bash
```

This script will:

1. Clone the repository into `~/.config` (if it doesn't already exist).  
2. Symlink `~/.tmux.conf` to the version in the repo.  
3. Set fish as your default shell (if installed).  

---

### Gitignore

This repository uses a whitelist-style `.gitignore` to track only the necessary config files
