#!/usr/bin/env bash
set -e

# Clone tmux config if not already present
if [ ! -d "$HOME/.tmux-config" ]; then
  git clone https://github.com/manthanrami/tmux-config.git "$HOME/.tmux-config"
fi

# Symlink tmux.conf
if [ -f "$HOME/.tmux.conf" ] || [ -L "$HOME/.tmux.conf" ]; then
  echo "Backing up existing ~/.tmux.conf to ~/.tmux.conf.backup"
  mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup"
fi
ln -s "$HOME/.tmux-config/.tmux.conf" "$HOME/.tmux.conf"

# Install TPM (tmux plugin manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Reload tmux if running
if tmux info &>/dev/null; then
  tmux source-file "$HOME/.tmux.conf"
  echo "tmux config reloaded."
else
  echo "tmux not running. Start tmux and press Prefix+I to install plugins."
fi

echo "✅ Tmux configuration installed successfully."
