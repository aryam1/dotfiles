-- ~/.config/nvim/init.lua
-- Minimal config — flesh out later

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.clipboard = "unnamedplus"

-- Leader key
vim.g.mapleader = " "

-- Basic keymaps
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>W", ":wq<CR>")
vim.keymap.set("n", "<leader>Q", ":q!<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>n", ":Neotree filesystem toggle right<CR>",{})

-- Plugins
require("config.lazy")

