#!/usr/bin/env bash
set -e

# --- Configuration ---
REPO_NAME="tmux-config"
TARGET_DIR="$HOME/.tmux-config"
TMUX_CONF="$HOME/.tmux.conf"
TPM_DIR="$HOME/.tmux/plugins/tpm"

echo "🔍 Checking dependencies..."

# Check for tmux
if ! command -v tmux >/dev/null 2>&1; then
  echo "❌ Error: tmux is not installed. Please install it first."
  exit 1
fi

# Check for git
if ! command -v git >/dev/null 2>&1; then
  echo "❌ Error: git is not installed. Please install it first."
  exit 1
fi

# Check for xclip (optional but recommended for clipboard)
if ! command -v xclip >/dev/null 2>&1; then
  echo "⚠️  Warning: xclip is not installed. Clipboard features might not work."
  echo "   Install it with: sudo apt install xclip (Debian/Ubuntu) or sudo dnf install xclip (Fedora)"
fi

# --- Setup Configuration Directory ---

# 1. Check if we are already inside a local clone
CURRENT_DIR=$(pwd)
if [ -f "$CURRENT_DIR/.tmux.conf" ] && [ -f "$CURRENT_DIR/install_tmux_config.sh" ]; then
  echo "🏠 Running from local clone. Using $CURRENT_DIR as the config source."
  SOURCE_DIR="$CURRENT_DIR"
# 2. Check if the target directory already exists
elif [ -d "$TARGET_DIR" ]; then
  echo "✅ Configuration directory $TARGET_DIR already exists."
  SOURCE_DIR="$TARGET_DIR"
# 3. Otherwise, clone it (handles remote execution via curl/wget)
else
  echo "📥 Cloning tmux configuration to $TARGET_DIR..."
  git clone https://github.com/manthanrami/tmux-config.git "$TARGET_DIR"
  SOURCE_DIR="$TARGET_DIR"
fi

# --- Symlink .tmux.conf ---

if [ -f "$TMUX_CONF" ] || [ -L "$TMUX_CONF" ]; then
  # Check if it's already symlinked to the right place
  if [ "$(readlink -f "$TMUX_CONF")" = "$(readlink -f "$SOURCE_DIR/.tmux.conf")" ]; then
    echo "✅ ~/.tmux.conf is already correctly linked."
  else
    BACKUP_FILE="$TMUX_CONF.backup.$(date +%Y%m%d_%H%M%S)"
    echo "📦 Backing up existing ~/.tmux.conf to $BACKUP_FILE"
    mv "$TMUX_CONF" "$BACKUP_FILE"
    echo "🔗 Creating symlink to $SOURCE_DIR/.tmux.conf"
    ln -s "$SOURCE_DIR/.tmux.conf" "$TMUX_CONF"
  fi
else
  echo "🔗 Creating symlink to $SOURCE_DIR/.tmux.conf"
  ln -s "$SOURCE_DIR/.tmux.conf" "$TMUX_CONF"
fi

# --- Install TPM ---

if [ ! -d "$TPM_DIR" ]; then
  echo "📥 Installing TPM (Tmux Plugin Manager)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "✅ TPM is already installed."
fi

# --- Reload Tmux ---

if tmux info &>/dev/null; then
  echo "🔄 Reloading tmux configuration..."
  tmux source-file "$TMUX_CONF"
  echo "✨ tmux config reloaded."
else
  echo "ℹ️  tmux is not running. Start tmux and press 'Prefix + I' to install plugins."
fi

echo "✅ Tmux configuration installed successfully!"
