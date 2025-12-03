vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Themes
    use 'sainnhe/gruvbox-material'
    use 'shaunsingh/nord.nvim'
    use 'dgox16/oldworld.nvim'
    use 'Mofiqul/vscode.nvim'
    use 'bluz71/vim-moonfly-colors'
    use 'kdheepak/monochrome.nvim'
    use 'catppuccin/nvim'
    use 'nyoom-engineering/oxocarbon.nvim'
    use 'vague2k/vague.nvim'
    use "blazkowolf/gruber-darker.nvim"
    use 'ericbn/vim-solarized'

    -- TS, LSP
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({ 'neovim/nvim-lspconfig' })
    use({ 'hrsh7th/nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp' })

    use "williamboman/mason-lspconfig.nvim"

    use 'mfussenegger/nvim-dap'
    use {
        "igorlfs/nvim-dap-view",
        config = function()
            require("dap-view").setup({})
        end,
    }

    use({
        'mrcjkb/rustaceanvim',
        version = "^6",
        lazy = false,
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
        },
    })

    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup()
        end
    }

    use {
        'nvim-flutter/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    }


    -- etc
    use {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup {
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            }
        end
    }

    use 'ThePrimeagen/harpoon'
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    use {
        'L3MON4D3/LuaSnip',
        requires = { 'rafamadriz/friendly-snippets' }
    }
    use 'andweeb/presence.nvim'
    use 'tikhomirov/vim-glsl'
    use 'nvim-tree/nvim-tree.lua'
end)
