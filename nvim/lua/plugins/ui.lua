-- ━━━ UI 元件 ━━━
return {
    -- 狀態列
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

    -- 縮排指引線
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "│" },
            scope = { enabled = true },
        },
    },

    -- 按鍵提示（按 Leader 後會顯示可用的按鍵）
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Git 狀態標記（左側欄顯示新增/修改/刪除）
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- 圖示支援
    { "nvim-tree/nvim-web-devicons", lazy = true },
}
