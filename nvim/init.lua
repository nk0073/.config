-- essentials before doing anything
vim.o.termguicolors = true
vim.g.mapleader = " "


-- Packages
-- some packages require binaries so those are needed (seperated by space):
-- void-linux names: lua-language-server clang-tools-extra ripgrep
-- non-system packaged: rust-analyzer
local gh = function(x) return 'https://github.com/' .. x end
vim.pack.add({
    gh('vague-theme/vague.nvim'),
    gh('blazkowolf/gruber-darker.nvim'),

    gh('romus204/tree-sitter-manager.nvim'),
    gh('neovim/nvim-lspconfig'),
    gh('hrsh7th/nvim-cmp'),
    gh('hrsh7th/cmp-nvim-lsp'),

    gh('mfussenegger/nvim-dap'),
    gh('nvim-neotest/nvim-nio'),
    gh('rcarriga/nvim-dap-ui'), -- configure , use <leader>mv to open

    { src = gh('mrcjkb/rustaceanvim'), version = vim.version.range('^9') },

    gh('catgoose/nvim-colorizer.lua'),

    gh('ThePrimeagen/harpoon'),

    gh('nvim-tree/nvim-tree.lua'),

    gh('windwp/nvim-autopairs'),

    -- gh('andweeb/presence.nvim'),

    gh('lambdalisue/vim-suda'),

    gh('nvim-lua/plenary.nvim'),
    gh('nvim-telescope/telescope.nvim'),
})
require("colorizer").setup()
require("nvim-autopairs").setup({})

-- treesitter
require('tree-sitter-manager').setup({
    ensure_installed = {
        'c',
        'lua',
        'cpp',
        'rust',
        'gdscript',
        'gdshader',
        'markdown',
        'vim',
    },
    highlight = true,
    auto_install = true,
})

-- lsp
-- list of binds for lsp if forgotten:
-- gri for implementation ; gd for declaration ; gD for definition ;
-- grn for rename ; grt for type definition ; grr for references ;
-- gra for code action ; <C-w>d for diagnostics ;
-- <C-s> in insert for signature help
local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'nvim_lsp' },
    },
})

vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

vim.lsp.config('lua_ls', {
    settings = { Lua = { diagnostics = { globals = { 'vim' }, }, },},
})

vim.lsp.enable({
    'clangd',
    'gdscript',
    "lua_ls",
})

-- dap
local dap = require('dap')
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/sbin/lldb-dap',
    name = 'lldb',
}

dap.configurations.c = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}
dap.configurations.cpp = dap.configurations.c

dap.adapters.godot = {
    type = 'server',
    host = '127.0.0.1',
    port = 6006,
}

dap.configurations.gdscript = {
    {
        type = 'godot',
        request = 'launch',
        name = 'Launch scene',
        project = '${workspaceFolder}',
        launch_scene = true,
    },
}

-- dap-ui
local dapui = require('dapui') ; dapui.setup()
vim.keymap.set('n', '<leader>du', dapui.toggle)

-- harpoon
local haproon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>a', haproon_mark.add_file)
vim.keymap.set('n', '<C-e>', harpoon_ui.toggle_quick_menu)

vim.keymap.set('n', '<C-h>', function() harpoon_ui.nav_file(1) end)
vim.keymap.set('n', '<C-t>', function() harpoon_ui.nav_file(2) end)
vim.keymap.set('n', '<C-n>', function() harpoon_ui.nav_file(3) end)
vim.keymap.set('n', '<C-s>', function() harpoon_ui.nav_file(4) end)
vim.keymap.set('n', '<C-z>', function() harpoon_ui.nav_file(5) end)

-- nvim-tree
require('nvim-tree').setup({
    view = { width = 50, side = 'right' },
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
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        vim.keymap.set('n', '=', api.tree.change_root_to_node, {
            buffer = bufnr,
            silent = true,
            nowait = true,
        })
    end,
})

vim.keymap.set('n', '<leader>pv', '<cmd>NvimTreeToggle<CR>', { silent = true })

-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', telescope.find_files, {})
vim.keymap.set('n', '<leader>pw', function()
    telescope.grep_string({ search = vim.fn.input('Grep > ') })
end)


-- Visuals
vim.o.guicursor = 'a:block,r-cr-o:hor20'

-- vim.cmd.colorscheme('vague')
vim.cmd.colorscheme('gruber-darker')

-- transparent bg
vim.cmd [[
  highlight Normal       guibg=NONE ctermbg=NONE
  highlight NormalNC     guibg=NONE ctermbg=NONE
  highlight EndOfBuffer  guibg=NONE ctermbg=NONE
  highlight LineNr       guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
]]


-- Default binds
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set('i', '<C-S-v>', '<C-r>+', { noremap = true, silent = true })
vim.keymap.set('x', '<C-y>', '"+y', { noremap = true, silent = true })
vim.keymap.set('x', '<C-p>', '"+p', { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tt", ":split | resize 10 | terminal")
vim.keymap.set("n", "q:", "<nop>", { noremap = true, silent = true }) -- ctrl + f is better

vim.keymap.set('n', '<C-Up>',    '<cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Down>',  '<cmd>resize -2<CR>')
vim.keymap.set('n', '<C-Left>',  '<cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<C-k>',    '<cmd>resize +6<CR>')
vim.keymap.set('n', '<C-j>',  '<cmd>resize -6<CR>')
vim.keymap.set('n', '<C-h>',  '<cmd>vertical resize -6<CR>')
vim.keymap.set('n', '<C-l>', '<cmd>vertical resize +6<CR>')

-- Options
vim.o.nu = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.colorcolumn = '80'

vim.cmd('filetype plugin indent on')
vim.o.wrap = false

vim.o.undofile = true

vim.o.hlsearch = false

vim.o.scrolloff = 8
vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

-- Misc
-- listen to godothost if in a gd project
-- listen to godothost if in a gd project
local project = vim.fn.getcwd() .. '/project.godot'
if vim.fn.filereadable(project) == 1 then
    local socket = vim.fn.getcwd() .. '/godothost'
    pcall(vim.uv.fs_unlink, socket)
    vim.fn.serverstart(socket)
end
