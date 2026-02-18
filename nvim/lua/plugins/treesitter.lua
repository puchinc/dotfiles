-- ━━━ Treesitter: Syntax Highlighting and Code Parsing ━━━
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
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
        },
    },
}
