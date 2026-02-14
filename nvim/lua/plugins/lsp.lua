-- ━━━ LSP + 自動補全 ━━━
return {
    -- Mason：自動安裝 LSP Server
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

    -- 自動補全引擎（blink.cmp - 比 nvim-cmp 更快更簡單）
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
                    preset = "super-tab",  -- Tab/S-Tab 選擇，Enter 確認
                },
                appearance = {
                    nerd_font_variant = "mono",
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
            })

            -- LSP 設定（Neovim 0.11+ 原生 API，不再用 require("lspconfig")）
            -- 全域 capabilities（套用到所有 LSP server）
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- Lua LSP 特殊設定（讓它認識 vim 全域變數）
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- 啟用所有 LSP server
            vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "rust_analyzer" })

            -- LSP 按鍵映射（當 LSP attach 到 buffer 時生效）
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, {
                            buffer = event.buf, desc = "LSP: " .. desc,
                        })
                    end
                    local tb = require("telescope.builtin")

                    map("gd", tb.lsp_definitions,      "跳到定義")
                    map("gr", tb.lsp_references,        "查看引用")
                    map("gI", tb.lsp_implementations,   "跳到實作")
                    map("gy", tb.lsp_type_definitions,  "跳到型別定義")
                    map("K",  vim.lsp.buf.hover,        "懸浮文件")
                    map("<leader>rn", vim.lsp.buf.rename,       "重新命名")
                    map("<leader>ca", vim.lsp.buf.code_action,  "程式碼操作")
                    map("<leader>ds", tb.lsp_document_symbols,  "文件符號")
                end,
            })
        end,
    },

    -- 格式化
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
            end, { desc = "格式化" })
        end,
    },
}
