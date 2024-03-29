-- # vim: foldmethod=marker
-- # vim: foldmarker=({{,}})

-- All LuaSnips latex snippets should be initialised here


--# Latex ------------------------------------({{

-- All special characters are mapped in this file:
require("snippets.latex.special_characters")

-- All special mathemtaical operations are mapped in this file:
require("snippets.latex.math_ops")

-- All environments are mapped in this file:
require("snippets.latex.environments")

-- Drawing Snippets:
require("snippets.latex.drawing_plotting")

-- Drawing Snippets:
require("snippets.latex.templates.document_std_template")

-- Modifier: all snippets with the form \form{surrounding}
require("snippets.latex.modyfier")


local ls = require("luasnip")
local utils = require("snippets.latex.util.utils")
local autosnippets = {}
local is_math = utils.with_opts(utils.is_math, true)

for _, snip in ipairs(require("snippets.latex.math_fractions")) do
    snip.regTrig = true 
    snip.condition =  is_math 
    table.insert(autosnippets, snip)
end

ls.add_snippets("tex", autosnippets, {
type = "autosnippets",
default_priority = 0,
})

---------)}}




--# Lua ------------------------------------({{
	
-- Template for creating new snippet pages:
require("snippets.lua.snippet_page_template")

--)}}
