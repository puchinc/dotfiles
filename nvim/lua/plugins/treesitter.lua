-- ━━━ Treesitter：語法高亮和程式碼解析 ━━━
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash", "c", "cpp", "css", "go", "html",
                    "javascript", "json", "lua", "markdown",
                    "markdown_inline", "python", "rust",
                    "toml", "tsx", "typescript", "vim",
                    "vimdoc", "yaml",
                },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
