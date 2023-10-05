-- GENERAL SETTINGS
-- Dependencies:


--Very Basic nvim settings not using any plugins are in the basic folder:
require('basic/basic_nvim_settings')
require('basic.colorscheme')

-- -- Plugin Settings:
require('plugin.packer') -- This file installs packer automatically, if the file plugin/packer_compiled doesn't exist.
require('plugin.luasnips')
require('plugin.nvim-cmp')
require('plugin.treesitter')
require('plugin.VimTeX')

-- nvim-lint Linter:
require("plugin.nvim_lint")

-- Comments:
require("plugin.comment")

-- All Keymaps should be defined here:
require('basic.keymaps')

--LSP:
require("plugin.mason")

-- Formatter:
require("plugin.formatter")

-- Folding:
require("plugin.nvim_ufo")




-- -- Snippets from Luasnips:
require('snippets.init')
-- local latex_init = require('snippets.init')
