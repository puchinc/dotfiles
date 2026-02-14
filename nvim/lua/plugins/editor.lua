-- ━━━ 編輯器基本功能 ━━━
return {
    -- 括號自動配對
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    -- 環繞操作（ys, ds, cs - 跟你原來的 vim-surround 一樣）
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- 快速註解（gcc 註解一行, gc 註解選取區域）
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- 檔案樹（按 \ 開關，跟你原來的 NERDTree 習慣一樣）
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- nvim-tree 需要關閉 netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                view = { width = 35 },
                filters = { dotfiles = false },
            })

            vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "檔案樹" })
            vim.keymap.set("n", "<C-f>", "<cmd>NvimTreeFindFile<CR>", { desc = "定位當前檔案" })
        end,
    },

    -- tmux 與 Neovim 之間無縫切換視窗（Ctrl+hjkl）
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },
}
