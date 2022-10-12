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
  	
  	-- Colorschemes:
	use 'bluz71/vim-moonfly-colors' 

	-- LuaSnips:
	use({"L3MON4D3/LuaSnip"})

	--nvim-cmp (Snippet Engine):
	use "hrsh7th/nvim-cmp"
  	use 'hrsh7th/cmp-nvim-lsp'
 	use 'saadparwaiz1/cmp_luasnip'

	--Treesitter: 
	use "nvim-treesitter/nvim-treesitter"

	-- VimTeX
	use "lervag/vimtex"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


