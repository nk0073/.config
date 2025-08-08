local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {}) -- search files
vim.keymap.set('n', '<leader>pw', function() -- search word in files
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
