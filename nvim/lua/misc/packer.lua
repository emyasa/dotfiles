-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }


    -- color schemes
    use({ "rose-pine/neovim", as = "rose-pine" })
    use({ "rebelot/kanagawa.nvim", as = "kanagawa" })
    use({ "folke/tokyonight.nvim", as = "tokyonight" })


    use ({'nvim-treesitter/nvim-treesitter', branch='master', run = ':TSUpdate'})

    use { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' }

    -- file-trees
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    -- file-explorer
    use 'stevearc/oil.nvim'

    -- binary manager
    use 'mason-org/mason.nvim'
    use 'mfussenegger/nvim-jdtls'
    use 'neovim/nvim-lspconfig'
    use 'windwp/nvim-autopairs'

    -- auto-complete
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",

            -- snippets
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use { "lewis6991/gitsigns.nvim" }
end)
