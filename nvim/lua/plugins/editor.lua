-- ━━━ Core Editor Features ━━━
return {
    -- Auto bracket pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    -- Surround operations (ys, ds, cs - same as vim-surround)
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- Quick comments (gcc to comment a line, gc to comment selection)
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- File tree (toggle with \, same habit as NERDTree)
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- nvim-tree requires disabling netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                view = { width = 35 },
                filters = { dotfiles = false },
            })

            vim.keymap.set("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "File tree" })
            vim.keymap.set("n", "<C-f>", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal current file" })
        end,
    },

    -- Seamless window navigation between tmux and Neovim (Ctrl+hjkl)
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },
}
