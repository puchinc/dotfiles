#!/bin/bash
# dotfiles 安裝腳本
# 用法: cd ~/dotfiles && bash install.sh

set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "=== Dotfiles 安裝 ==="
echo "來源: $DOTFILES"
echo ""

# 建立備份資料夾
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP"

# 輔助函數：備份後建立 symlink
link_it() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "  備份: $dest -> $BACKUP/"
        mv "$dest" "$BACKUP/"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "  連結: $dest -> $src"
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

# ━━━ CLAUDE.md（讓 Claude Code 了解這個 repo）━━━
echo ""
echo "=== 完成 ==="
echo "舊檔案備份在: $BACKUP"
echo ""
echo "下一步："
echo "  1. 重啟終端"
echo "  2. 開 nvim，等外掛安裝完成"
echo "  3. cd ~/dotfiles && claude  （讓 Claude Code 管理你的配置）"
