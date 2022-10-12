-- GENERAL SETTINGS
-- Dependencies: 


--Very Basic nvim settings not using any plugins are in the basic folder:
require('basic/basic_nvim_settings')
require('basic.colorscheme')

-- Plugin Settings:
require('plugin.packer') -- This file installs packer automatically, if the file plugin/packer_compiled doesn't exist.
require('plugin.luasnips')
require('plugin.nvim-cmp')
require('plugin.treesitter')
require('plugin.VimTeX')

-- All Keymaps should be defined here:
require('basic.keymaps')

-- Snippets from Luasnips:
require('snippets.latex')

