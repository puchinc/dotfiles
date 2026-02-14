-- ━━━ Telescope：檔案搜尋和導航 ━━━
-- 需要先安裝: brew install ripgrep fd
return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<Esc>"] = actions.close,
                        },
                    },
                    file_ignore_patterns = {
                        "node_modules", ".git/", "__pycache__",
                        "%.pyc", "%.class", "%.o",
                    },
                },
            })

            telescope.load_extension("fzf")

            -- 按鍵映射
            local builtin = require("telescope.builtin")
            local map = vim.keymap.set
            map("n", "<leader>ff", builtin.find_files,  { desc = "搜尋檔案" })
            map("n", "<leader>fg", builtin.live_grep,   { desc = "全域搜尋文字" })
            map("n", "<leader>fb", builtin.buffers,     { desc = "切換 Buffer" })
            map("n", "<leader>fh", builtin.help_tags,   { desc = "搜尋說明文件" })
            map("n", "<leader>fr", builtin.oldfiles,    { desc = "最近開啟的檔案" })
            map("n", "<leader>fc", builtin.git_commits, { desc = "Git Commits" })
            map("n", "<leader>fs", builtin.git_status,  { desc = "Git Status" })
            -- gd / gr 由 LSP 設定（見 lsp.lua）
        end,
    },
}
