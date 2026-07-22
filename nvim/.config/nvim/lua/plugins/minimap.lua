return {
    {
        "Isrothy/neominimap.nvim",
        dependancies = {"lewis6991/gitsigns.nvim"},
        version = "v3.x x",
        lazy = false,
        keys = {
            { "<leader>m", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
        },
        init = function()
            vim.opt.wrap = false
            vim.opt.sidescrolloff = 36 -- Set a large value
            ---@type Neominimap.UserConfig
            vim.g.neominimap = {
                auto_enable = true,
                click = { enabled = true },
            }
        end,
    },
}
