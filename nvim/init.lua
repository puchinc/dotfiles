-- ╔══════════════════════════════════════════╗
-- ║          Neovim 配置 (init.lua)          ║
-- ║   Ghostty + tmux + Neovim + Claude Code  ║
-- ╚══════════════════════════════════════════╝

-- Leader 鍵設為空白鍵（必須在載入外掛之前設定）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ━━━ 基本設定 ━━━
vim.opt.number = true              -- 行號
vim.opt.relativenumber = true      -- 相對行號
vim.opt.cursorline = true          -- 高亮當前行
vim.opt.signcolumn = "yes"         -- 永遠顯示符號列

vim.opt.tabstop = 4                -- Tab 寬度
vim.opt.shiftwidth = 4             -- 縮排寬度
vim.opt.softtabstop = 4
vim.opt.expandtab = true           -- Tab 轉空格
vim.opt.smartindent = true

vim.opt.wrap = true                -- 自動換行
vim.opt.linebreak = true           -- 在單字邊界換行
vim.opt.ignorecase = true          -- 搜尋忽略大小寫
vim.opt.smartcase = true           -- 有大寫時區分大小寫
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.splitright = true          -- 垂直分割在右邊
vim.opt.splitbelow = true          -- 水平分割在下方
vim.opt.clipboard = "unnamedplus"  -- 系統剪貼簿
vim.opt.mouse = "a"                -- 啟用滑鼠
vim.opt.termguicolors = true       -- 真彩色
vim.opt.undofile = true            -- 持久化 undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 250           -- 更快的更新
vim.opt.timeoutlen = 400
vim.opt.scrolloff = 8              -- 捲動時保留 8 行

-- ━━━ 按鍵映射 ━━━
local map = vim.keymap.set

-- 長行上下移動用 gj/gk
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- 清除搜尋高亮
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 視窗切換（搭配 tmux 用 Ctrl+hjkl）
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffer 切換
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "上一個 Buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "下一個 Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "關閉 Buffer" })

-- 快速存檔
map("n", "<leader>w", "<cmd>w<CR>", { desc = "存檔" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "離開" })

-- 移動選取的行
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "下移選取行" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "上移選取行" })

-- 保持游標位置的 J
map("n", "J", "mzJ`z")

-- 搜尋時游標保持在中間
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- 複製整個檔案路徑
map("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "複製檔案路徑" })

-- ━━━ 載入外掛（lazy.nvim）━━━
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    change_detection = { notify = false },
})
