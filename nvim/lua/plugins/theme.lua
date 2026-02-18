-- ━━━ Theme: Catppuccin Mocha ━━━
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = false,
                integrations = {
                    gitsigns = true,
                    telescope = true,
                    treesitter = true,
                    mason = true,
                    which_key = true,
                    indent_blankline = { enabled = true },
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
