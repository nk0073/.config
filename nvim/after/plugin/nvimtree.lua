
local api = require("nvim-tree.api")

vim.keymap.set('n', '<leader>pv', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "=", api.tree.change_root_to_node, {noremap = true, silent = true, nowait = true})


require("nvim-tree").setup({
  view = {
    width = 50,
    side = "right",
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
        modified = false,
        diagnostics = false,
      },
    },
  },
})

