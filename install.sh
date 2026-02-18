#!/bin/bash
# dotfiles install script
# Usage: cd ~/dotfiles && bash install.sh

set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles Install ==="
echo "Source: $DOTFILES"
echo ""

# Create backup directory
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP"

# Helper: backup existing file then create symlink
link_it() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "  Backup: $dest -> $BACKUP/"
        mv "$dest" "$BACKUP/"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "  Link: $dest -> $src"
}

# ━━━ Neovim ━━━
echo ""
echo "[Neovim]"
link_it "$DOTFILES/nvim" "$HOME/.config/nvim"

# ━━━ Ghostty ━━━
echo ""
echo "[Ghostty]"
link_it "$DOTFILES/ghostty" "$HOME/.config/ghostty"

# ━━━ Zsh ━━━
echo ""
echo "[Zsh]"
link_it "$DOTFILES/zshrc" "$HOME/.zshrc"

# ━━━ Tmux ━━━
echo ""
echo "[Tmux]"
if [ -f "$DOTFILES/tmux.conf" ]; then
    link_it "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"
fi

# ━━━ Claude Code ━━━
echo ""
echo "[Claude Code]"
if [ -d "$DOTFILES/claude" ]; then
    link_it "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
fi

# ━━━ CLAUDE.md (lets Claude Code understand this repo) ━━━
echo ""
echo "=== Done ==="
echo "Old files backed up to: $BACKUP"
echo ""
echo "Next steps:"
echo "  1. Restart terminal"
echo "  2. Open nvim and wait for plugins to install"
echo "  3. cd ~/dotfiles && claude  (let Claude Code manage your config)"
