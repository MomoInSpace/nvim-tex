-- All LuaSnips latex snippets should be initialised here

-- All special characters are mapped in this file:
require("snippets.latex.special_characters")

-- All environments are mapped in this file:
require("snippets.latex.environments")

-- Drawing Snippets:
require("snippets.latex.drawing_plotting")


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
