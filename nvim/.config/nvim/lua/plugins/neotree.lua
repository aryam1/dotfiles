return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        priority = 9000,
        lazy = false,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons",
        },
        opts = {
            window = {
                position = "right",
                width = 30,
            },
            filesystem = {
                hijack_netrw_behavior = "open_current",
                filtered_items = {
                    visible = true,
                }
            },
        },
    },
    {
        "Crysthamus/nvim-file-operations",
        -- branch = "compat" -- if you are on Neovim <= 0.10
        dependencies = {
          "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
        },
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        opts = {
            filter_rules = {
                include_current_win = false,
                autoselect_one = true,
                -- filter using buffer options
                bo = {
                  -- if the file type is one of following, the window will be ignored
                  filetype = { "neo-tree", "neo-tree-popup", "notify" },
                  -- if the buffer type is one of following, the window will be ignored
                  buftype = { "terminal", "quickfix" },
                },
            },
        }
    }
}
