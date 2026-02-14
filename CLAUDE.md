# Dotfiles

這是 puchin 的開發環境配置，由 Claude Code 協助管理。

## 環境

- **終端:** Ghostty
- **Shell:** zsh (macOS 原生，不用 Oh My Zsh)
- **多工:** tmux
- **編輯器:** Neovim (從 Vim 遷移過來)
- **AI 工具:** Claude Code
- **主題:** Catppuccin Mocha（全環境統一）

## 目錄結構

```
~/dotfiles/
├── CLAUDE.md          # 你正在看的這個檔案
├── install.sh         # 一鍵安裝腳本（建立 symlink）
├── nvim/              # -> ~/.config/nvim
│   ├── init.lua
│   └── lua/plugins/
│       ├── theme.lua
│       ├── ui.lua
│       ├── telescope.lua
│       ├── treesitter.lua
│       ├── lsp.lua
│       └── editor.lua
├── ghostty/           # -> ~/.config/ghostty
│   └── config
├── zshrc              # -> ~/.zshrc
└── tmux.conf          # -> ~/.tmux.conf
```

## 規範

- Neovim 配置用 Lua，套件管理用 lazy.nvim
- 偏好極簡配置，不加不需要的外掛
- zsh 不用 Oh My Zsh，保持 .zshrc 精簡
- 所有配置使用 Catppuccin Mocha 主題
- 修改配置後確保 symlink 結構不被破壞

## 常用指令

- `bash install.sh` — 部署所有 symlink
- `nvim` — 啟動 Neovim
- `brew install neovim ripgrep fd` — 安裝依賴
