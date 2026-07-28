return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		lazy = false,

		vim.opt.fillchars:append({
			foldopen = "▼",
			foldclose = "▶",
			foldsep = " ",
		}),

		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- wrap in autocmd so colorscheme reloads don't wipe it

			local function foldtext(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d"):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0

				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						table.insert(newVirtText, { chunkText, chunk[2] })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end

				table.insert(newVirtText, { suffix, "UfoFoldedLines" })
				return newVirtText
			end

			vim.api.nvim_set_hl(0, "UfoFoldedLines", { fg = "#cba6f7", italic = true })

			require("ufo").setup({
				provider_selector = function(_, _, _)
					return { "lsp", "indent" }
				end,
				fold_virt_text_handler = foldtext,
			})

			vim.keymap.set("n", "<leader>[", "zc") -- fold current section
			vim.keymap.set("n", "<leader>]", require("ufo").openFoldsExceptKinds) -- open current section
			vim.keymap.set("n", "<leader>{", require("ufo").closeAllFolds) -- fold all
			vim.keymap.set("n", "<leader>}", require("ufo").openAllFolds) -- open all
		end,
	},
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				chunk = {
					enable = true,
					use_treesitter = true,
					style = "#b4befe", -- Mocha Lavender
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
				},
				indent = {
					enable = true,
					chars = {
						"│",
						"¦",
						"┆",
						"┊",
					},
					style = {'#45475a' },
				},
				line_num = {
					enable = true,
					use_treesitter = true,
					style = "#b4befe", -- Mocha Lavender
					chars = {
						horizontal_line = "─",
						vertical_line = "│",
						left_top = "╭",
						left_bottom = "╰",
						right_arrow = ">",
					},
				},
				blank = {
					enable = false, -- skip unless you also want blank-line indent guides
				},
			})
		end,
	},
}
