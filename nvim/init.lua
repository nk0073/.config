-- Visuals
vim.o.guicursor = "n-v-c-sm:block,i:ver25,r-cr-o:hor20"
vim.g.nord_disable_background = true
vim.cmd.colorscheme('vague')
vim.o.background = 'dark'
vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
]]

-- Binds
vim.g.mapleader = " "
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set('i', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
vim.keymap.set('x', '<C-y>', '"+y', { noremap = true, silent = true }) 
vim.keymap.set('x', '<C-p>', '"+p', { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tt", ":split | resize 10 | terminal")
vim.keymap.set("n", "q:", "<nop>", { noremap = true, silent = true })

-- Options
vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.si = true
vim.o.wrap = false

vim.o.undofile = true

vim.o.hlsearch = false

vim.o.termguicolors = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.o.updatetime = 50


