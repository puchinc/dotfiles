# Dotfiles

This is puchin's development environment configuration, managed with Claude Code.

## Environment

- **Terminal:** Ghostty
- **Shell:** zsh (macOS native, no Oh My Zsh)
- **Multiplexer:** tmux
- **Editor:** Neovim (migrated from Vim)
- **AI Tool:** Claude Code
- **Theme:** Catppuccin Mocha (unified across all configs)

## Directory Structure

```
~/dotfiles/
├── CLAUDE.md          # This file
├── install.sh         # One-shot install script (creates symlinks)
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

## Conventions

- Neovim config uses Lua, plugin manager is lazy.nvim
- Prefer minimal config, don't add unnecessary plugins
- zsh without Oh My Zsh, keep .zshrc lean
- All configs use Catppuccin Mocha theme
- After modifying configs, ensure the symlink structure is not broken

## Common Commands

- `bash install.sh` — Deploy all symlinks
- `nvim` — Launch Neovim
- `brew install neovim ripgrep fd` — Install dependencies
