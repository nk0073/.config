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

