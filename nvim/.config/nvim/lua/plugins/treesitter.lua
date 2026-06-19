return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {"all"},
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
