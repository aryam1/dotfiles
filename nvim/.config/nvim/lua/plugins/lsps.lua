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
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            -- adds folding to all lsps
            vim.lsp.config('*', {
                capabilities = capabilities,
            })
        end,
    }
}
