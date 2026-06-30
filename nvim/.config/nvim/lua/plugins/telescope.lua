return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope help tags" },
        },
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    }
                }
            }
            require("telescope").load_extension("ui-select")
        end
    }
}
