prev_value =""

return {
    {
        'mfussenegger/nvim-dap',
        name = "dap",
        config = function()
            local dap = require('dap')
            local breaks = require('dap.breakpoints')
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
            vim.keymap.set('n', '<leader>dc', function ()
                local bufnr = vim.api.nvim_get_current_buf()
                local bps = breaks.get(bufnr)

                local def = ""

                local current_line = vim.api.nvim_win_get_cursor(0)[1]
                local current_breaks = bps and bps[bufnr] or {}
                for _, bp in ipairs(current_breaks) do
                    if bp.line == current_line then
                        if bp.condition then
                            def = bp.condition
                        end
                        break
                    end
                end

                local condition = vim.fn.input({ prompt = "Enter condition: ", default = def })
                dap.set_breakpoint(condition)
            end)
            vim.keymap.set('n', '<f5>', dap.continue)

            -- vim.highlight.create('DapBreakpoint', { ctermbg=0, guifg='#993939', guibg='#31353f' }, false)
            -- vim.highlight.create('DapLogPoint', { ctermbg=0, guifg='#61afef', guibg='#31353f' }, false)
            -- vim.highlight.create('DapStopped', { ctermbg=0, guifg='#98c379', guibg='#31353f' }, false)

            vim.fn.sign_define('DapBreakpoint', { text='🚏', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointCondition', { text='🐛', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
            vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
            vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
            vim.fn.sign_define('DapStopped', { text='👀', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
        end
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {"mfussenegger/nvim-dap"},
        config = function()
            -- require('dap-python').setup('uv')
            require('dap-python').setup('debugpy-adapter') -- or uv, or path to python, see #usage
            function get_user_args_for_pytest()
                local input = vim.fn.input({ prompt = "Enter arguments (space-separated): ", default = prev_value })
                prev_value = input
                return vim.split(input, " ")
            end
            table.insert(require('dap').configurations.python, {
                type = 'python',
                request = 'launch',
                name = 'Run pytest',
                module = 'pytest',
                console = "integratedTerminal",
                args = get_user_args_for_pytest
            })
        end
    },
    { 
        "rcarriga/nvim-dap-ui", 
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, 
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
}
