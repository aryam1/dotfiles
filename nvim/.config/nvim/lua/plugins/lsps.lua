return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        opts = {}
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                -- Python
                "basedpyright",

                -- C/C++
                "clangd",

                -- TypeScript / JavaScript
                "vtsls",

                -- Lua (Neovim config)
                "lua_ls",

                -- Web / config
                "html",
                "cssls",
                "jsonls",
                "yamlls",
                "taplo",

                -- Shell
                "bashls",

                -- Extras
                "dockerls",
                "marksman",
                "cmake",
              },
              automatic_installation = true,
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    }
}
