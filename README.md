# Ultimate Tmux Configuration
Custom `~/.tmux.conf` with quality-of-life tweaks, intuitive keybindings, a clean status bar, and TPM plugin support.  
This config **adds features without overriding your original bindings**.

---

## 🚀 Quick Install

```bash
# Install tmux (Debian/Ubuntu)
sudo apt install tmux -y

# Fedora
sudo dnf install tmux -y

# openSUSE
sudo zypper install tmux -y

#Clone and run the installer:
```bash
git clone https://github.com/yourname/tmux-config.git ~/.tmux-config
sh ~/.tmux-config/install_tmux_config.sh
```

Start tmux, then press:
Prefix + I → Install plugins
Prefix + Ctrl-s → Save session (Resurrect)
Prefix + Ctrl-r → Restore session (Resurrect)

| Keys                    | Action                        |                      |
| ----------------------- | ----------------------------- | -------------------- |
| `Prefix + r`            | Reload config                 |                      |
| \`Prefix +              | \`                            | Vertical split (cwd) |
| `Prefix + -`            | Horizontal split (cwd)        |                      |
| `Alt + Arrows`          | Move between panes            |                      |
| `H J K L` (with Prefix) | Resize pane (repeatable)      |                      |
| `b`                     | Break pane → new window       |                      |
| `j`                     | Join pane from another window |                      |
| `Ctrl-k`                | Clear pane history            |                      |
| `v / y` (vi-mode)       | Select / Copy to buffer       |                      |
| `Ctrl-v` (vi-mode)      | Toggle rectangular selection  |                      |
| `Y`                     | Yank entire pane to buffer    |                      |
| `Prefix + Ctrl-s`       | Save session (Resurrect)      |                      |
| `Prefix + Ctrl-r`       | Restore session (Resurrect)   |                      |

✨ Features

Better defaults
  - True color (Tc) + 256 colors
  - Windows/panes start at 1
  - Auto-renumber windows on close
  - Large scrollback (10k lines)
  - Mouse mode enabled

Copy mode
  - Vi-style navigation
  - Buffer copy/yank bindings (works without external tools)

Status bar
  - Minimal dark theme
  - Session name (left), window list (center), clock/date (right)
  - Active window highlighted (white on blue)

Plugins (via TPM)
  - tmux-plugins/tpm – plugin manager
  - tmux-plugins/tmux-resurrect – save/restore sessions
  - tmux-plugins/tmux-continuum – auto-save + auto-restore

📊 Visual Guide
Pane Splitting

Vertical split (Prefix + |):
+---------+---------+
|         |         |
|   LHS   |   RHS   |
|         |         |
+---------+---------+

Horizontal split (Prefix + -):
+-------------------+
|                   |
|       TOP         |
|                   |
+-------------------+
|                   |
|      BOTTOM       |
|                   |
+-------------------+

Pane Navigation (Alt + Arrows)
+---------+---------+
|         |         |
|   ← ↑   |   ↑ →   |
|   ↓     |     ↓   |
+---------+---------+

Pane Resizing (Prefix + H J K L)
H = expand left    L = expand right
J = expand down    K = expand up

📟 Status Bar Preview
[dev]  1:editor  2:server  3:logs                        14:42 27-Aug-25

[dev] → session name
1:editor 2:server 3:logs → windows
right side → clock/date
