-- This installs Packcer if not already installed:
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)

	-- Packer for installing packages:
	use 'wbthomason/packer.nvim'

  	-- Colorschemes and visual plugins:
	use 'bluz71/vim-moonfly-colors'
  	use 'itchyny/lightline.vim' -- Fancier statusline

	-- LuaSnips:
	use({"L3MON4D3/LuaSnip"})

	--nvim-cmp (Snippet Engine):
	use "hrsh7th/nvim-cmp"
  	use 'hrsh7th/cmp-nvim-lsp'
 	use 'saadparwaiz1/cmp_luasnip'

	-- Completion window:
	use 'onsails/lspkind-nvim' -- vscode-like pictograms for neovim lsp completion items
	use 'danymat/neogen'

	--Git:
	use 'tpope/vim-fugitive'


	-- MASON related packages:
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

		-- Mason-related:
		use 'mfussenegger/nvim-lint'
		use 'mhartington/formatter.nvim'
		use 'mfussenegger/nvim-dap'

	--Treesitter:
	use "nvim-treesitter/nvim-treesitter"

	-- UI to select things (files, grep results, open buffers...)
	use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
	use 'nvim-telescope/telescope-symbols.nvim'

	-- VimTeX
	use "lervag/vimtex"

	-- Easier Commenting:
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
