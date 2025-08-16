vim.keymap.set('n', '<leader>pv', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
require("nvim-tree").setup({
  view = {
    width = 50,
    side = "right",
  }
})

