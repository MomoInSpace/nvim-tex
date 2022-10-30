-- # vim: foldmethod=marker
-- # vim: foldmarker=({{,}})

-- some shorthands...
local ls = require("luasnip")
local s = ls.snippet
--local sn = ls.snippet_node
local t = ls.text_node
--local i = ls.insert_node
--local f = ls.function_node
--local c = ls.choice_node
--local d = ls.dynamic_node
--local r = ls.restore_node
--local l = require("luasnip.extras").lambda
--local rep = require("luasnip.extras").rep
--local p = require("luasnip.extras").partial
--local m = require("luasnip.extras").match
--local n = require("luasnip.extras").nonempty
--local dl = require("luasnip.extras").dynamic_lambda
--local fmt = require("luasnip.extras.fmt").fmt
--local fmta = require("luasnip.extras.fmt").fmta
--local types = require("luasnip.util.types")
--local conds = require("luasnip.extras.expand_conditions")
local parse = ls.parser.parse_snippet


local utils = require("snippets.latex.util.utils")
--local ts_utils = require("snippets.latex.util.ts_utils")
--local pipe = utils.pipe
local is_math = utils.with_opts(utils.is_math, true)
local not_math = utils.with_opts(utils.not_math, true)
--local no_backslash = utils.no_backslash

local auto_snippets = {}
local tab_snippets = {}

--# Start of Snippets -----------------------------------------({{
	
-- # basic operators------------------------------------({{
basic_math_ops_tab = {	
	parse({trig = "Dt", name = "Absolute Diff" }, "\\frac{D$1}{D $2} $0"),
	parse({trig = "dt", name = "Small absolute Diff" }, "\\frac{d$1}{d $2} $0"),
	parse({trig = "det", name = "partial diff" }, "\\frac{\\partial$1}{\\partial $2} $0"),
	parse({trig = "SI", name = "Si units" }, "\\SI{$1}{$2}$0"),

} 

for _, snip in ipairs(basic_math_ops_tab) do
    snip.condition = is_math--pipe({ is_math })
    snip.show_condition = is_math
    snip.wordTrig = false
	table.insert(tab_snippets,snip)
end
-- }})




-- }})



ls.add_snippets("tex",auto_snippets, {
	default_priority = 0,
	type = "autosnippets",
	key = "math_ops_auto"
})

ls.add_snippets("tex",tab_snippets, {
	default_priority = 0,
	key = "math_ops_tab"
})
