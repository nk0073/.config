vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings
vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    automatic_enable = true,
})

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    end,
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- Ensure snippets work
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- Use luasnip instead of vim.snippet
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
})

vim.lsp.config("clangd", {
    -- ain't working
    -- cmd = {"clangd", "-xc-header"}
})

vim.lsp.config("rust_analyzer", {
    enabled = false,
})

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup {
    PATH = "append",
}

vim.g.rustaceanvim = {
    server = {
        on_attach = function(client, bufnr)
            print("Loaded rustaceanvim")
        end,
        settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                    enable = true,
                    enableExperimental = true,
                },
            }
        },
    }
}

vim.keymap.set('n', '<Leader>tt', '<cmd>lua vim.cmd("RustLsp testables")<cr>', {})
