-- ━━━ Telescope: File Search and Navigation ━━━
-- Prerequisites: brew install ripgrep fd
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

            -- Keymaps
            local builtin = require("telescope.builtin")
            local map = vim.keymap.set
            map("n", "<leader>ff", builtin.find_files,  { desc = "Find files" })
            map("n", "<leader>fg", builtin.live_grep,   { desc = "Live grep" })
            map("n", "<leader>fb", builtin.buffers,     { desc = "Switch buffer" })
            map("n", "<leader>fh", builtin.help_tags,   { desc = "Search help" })
            map("n", "<leader>fr", builtin.oldfiles,    { desc = "Recent files" })
            map("n", "<leader>fc", builtin.git_commits, { desc = "Git commits" })
            map("n", "<leader>fs", builtin.git_status,  { desc = "Git status" })
            -- gd / gr are set by LSP (see lsp.lua)
        end,
    },
}
