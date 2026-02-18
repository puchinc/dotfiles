-- ━━━ UI Components ━━━
return {
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "│" },
            scope = { enabled = true },
        },
    },

    -- Key hints (shows available keys after pressing Leader)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Git status signs (shows added/modified/deleted in the gutter)
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Icon support
    { "nvim-tree/nvim-web-devicons", lazy = true },
}
