local dap_view = require("dap-view")
dap_view.setup({})

vim.keymap.set("n", "<leader>mv", function() require 'dap-view'.toggle() end);
