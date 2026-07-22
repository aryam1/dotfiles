return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "mason.nvim", "nvimtools/none-ls-extras.nvim"},
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                -- Python
                null_ls.builtins.formatting.black,
 
                -- C/C++
                null_ls.builtins.formatting.clang_format,

                -- Lua
                null_ls.builtins.formatting.stylua,

                -- TS/JS/web
                null_ls.builtins.formatting.prettier,
                require("none-ls.diagnostics.eslint_d"),

                -- Shell
                null_ls.builtins.formatting.shfmt,

                -- YAML / Docker (homelab compose files)
                null_ls.builtins.diagnostics.yamllint,
                null_ls.builtins.diagnostics.hadolint,

                -- Markdown
                null_ls.builtins.diagnostics.markdownlint,

                -- Git
                null_ls.builtins.code_actions.gitsigns,
            },
        })
    end,
}
