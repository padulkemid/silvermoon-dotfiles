vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Neovim
	use 'wbthomason/packer.nvim'
	use ({
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		requires = { {'nvim-lua/plenary.nvim'} }
	})
	use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('tpope/vim-fugitive')

	-- Colorscheme
	use({
		'cocopon/iceberg.vim',
		as = 'iceberg',
	})

	-- LSP
	use ({
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			{'saadparwaiz1/cmp_luasnip'}, -- Optional
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		}
	})


end)
