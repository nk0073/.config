local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-dap',
}

dap.configurations.c = {
    {
        type = 'lldb',
        request = 'launch',
        name = "Launch file",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
    {
        name = "Attach to process",
        type = "lldb",
        request = "attach",

        --original fallback
        -- pid = require('dap.utils').pick_process,

        pid = function()
          return tonumber(vim.fn.input('PID: '))
        end,


        -- fix this
        -- pid = (function()
        --     local str = vim.fn.input('Use PID or see process list (l): ')
        --     if str == "l" or str == "" then
        --         return require('dap.utils').pick_process
        --     else
        --         return function()
        --             return tonumber(vim.fn.input('PID: '))
        --         end
        --     end
        -- end)()
    },
}

dap.configurations.cpp = {
    {
        type = 'lldb',
        request = 'launch',
        name = "Launch file",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
}

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
