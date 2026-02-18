-- ━━━ LSP + Autocompletion ━━━
return {
    -- Mason: auto-install LSP servers
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",        -- Lua
                    "pyright",       -- Python
                    "ts_ls",         -- TypeScript/JavaScript
                    "rust_analyzer", -- Rust
                },
                automatic_installation = true,
            })
        end,
    },

    -- Autocompletion engine (blink.cmp - faster and simpler than nvim-cmp)
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            require("blink.cmp").setup({
                keymap = {
                    preset = "super-tab",  -- Tab/S-Tab to select, Enter to confirm
                },
                appearance = {
                    nerd_font_variant = "mono",
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
            })

            -- LSP config (Neovim 0.11+ native API, no longer using require("lspconfig"))
            -- Global capabilities (applied to all LSP servers)
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- Lua LSP special config (make it aware of the vim global)
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- Enable all LSP servers
            vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "rust_analyzer" })

            -- LSP keymaps (active when LSP attaches to a buffer)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, {
                            buffer = event.buf, desc = "LSP: " .. desc,
                        })
                    end
                    local tb = require("telescope.builtin")

                    map("gd", tb.lsp_definitions,      "Go to definition")
                    map("gr", tb.lsp_references,        "Find references")
                    map("gI", tb.lsp_implementations,   "Go to implementation")
                    map("gy", tb.lsp_type_definitions,  "Go to type definition")
                    map("K",  vim.lsp.buf.hover,        "Hover documentation")
                    map("<leader>rn", vim.lsp.buf.rename,       "Rename")
                    map("<leader>ca", vim.lsp.buf.code_action,  "Code action")
                    map("<leader>ds", tb.lsp_document_symbols,  "Document symbols")
                end,
            })
        end,
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "black" },
                    javascript = { "prettierd", "prettier", stop_after_first = true },
                    typescript = { "prettierd", "prettier", stop_after_first = true },
                    json = { "prettierd", "prettier", stop_after_first = true },
                    rust = { "rustfmt" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })
            vim.keymap.set("n", "<leader>fo", function()
                require("conform").format({ async = true })
            end, { desc = "Format" })
        end,
    },
}
