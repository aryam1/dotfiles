return {
    {
	    "catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
        priority = 1000,
        lsp_styles = {
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" }
            }
        },
        integrations = {
            aerial = true,
            alpha = true,
            cmp = true,
            dashboard = true,
            flash = true,
            fzf = true,
            grug_far = true,
            gitsigns = true,
            headlines = true,
            illuminate = true,
            indent_blankline = { enabled = true },
            leap = true,
            lsp_trouble = true,
            mason = true,
            mini = true,
            navic = { enabled = true, custom_bg = "lualine" },
            neotest = true,
            neotree = true,
            noice = true,
            notify = true,
            snacks = true,
            telescope = true,
            treesitter_context = true,
            which_key = true
        },
        specs = {
            {
                "akinsho/bufferline.nvim",
                optional = true,
                opts = function(_, opts)
                    if (vim.g.colors_name or ""):find("catppuccin") then
                        opts.highlights = require("catppuccin.special.bufferline").get_theme()
                    end
                end
            }
        },
		config = function()
			require("catppuccin").setup {
				transparent_background = true,
				custom_highlights = function(colours)
					return {
						NormalFloat = { bg = colours.none },
						FloatBorder = {
							fg = colours.lavender,
							bg = colours.none,
						},
						FloatTitle = {
							fg = colours.blue,
							bg = colours.none,
						},
						FloatFooter = {
							fg = colours.blue,
							bg = colours.none,
						},
					}
				end,
			}

			vim.g.catppuccin_flavour = "mocha"
			vim.cmd.colorscheme "catppuccin"
		end,
    },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons",
        },
        opts = {
            hijack_netrw_behavior = "open_current",
            window = {
                position = "right",
                width = 30,
            },
            filesystem = {
                show_hidden = true,
            }
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
        end,
    },
    {
        "Crysthamus/nvim-file-operations",
        -- branch = "compat" -- if you are on Neovim <= 0.10
        dependencies = {
          "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
        },
        config = function()
          require("nvim-file-operations").setup()
        end,
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
          require("window-picker").setup({
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
          })
        end,
    },
}

