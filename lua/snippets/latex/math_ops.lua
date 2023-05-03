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
local pipe = utils.pipe
local is_math = utils.with_opts(utils.is_math, true)
local not_math = utils.with_opts(utils.not_math, true)
local no_backslash = utils.no_backslash

local auto_snippets = {}
local tab_snippets = {}

--# Start of Snippets -----------------------------------------({{

-- # basic operators------------------------------------({{
basic_math_ops_tab = {
	parse({trig = "Dt", name = "Absolute Diff" }, 			"\\frac{\\Dt $1}{\\Dt $2} $0"),
	parse({trig = "Dtt", name = "Absolute Diff time" }, 	"\\frac{\\Dt $1}{\\Dt } $0"),
	parse({trig = "dt", name = "Small absolute Diff" }, 	"\\frac{\\d $1}{\\d $2} $0"),
	parse({trig = "det", name = "partial diff" }, 			"\\frac{\\partial $1}{\\partial $2} $0"),

	parse({trig = "Dt(", name = "Absolute Diff" }, 			"\\left(\\frac{\\Dt $1}{\\Dt $2}\\right) $0"),
	parse({trig = "Dtt(", name = "Absolute Diff time" },	"\\left(\\frac{\\Dt $1}{\\Dt }\\right) $0"),
	parse({trig = "dt(", name = "Small absolute Diff" }, 	"\\left(\frac{\\d $1}{\\d $2}\\right) $0"),
	parse({trig = "det(", name = "partial diff" }, 			"\\left(\\frac{\\partial $1}{\\partial $2}\\right) $0"),


	parse({trig = "SI", name = "Si units" }, "\\SI{$1}{$2}$0"),
	parse({trig = "si", name = "Si units small" }, "\\,\\si{$1}$0"),
	parse({trig = "int", name = "integral" }, "\\int_{$1}$0"),
	parse({trig = "Int", name = "Integral" }, "\\int_{$1}^{$2}$0"),
	parse({trig = "sum", name = "sum" }, "\\sum_{$1}$0"),
	parse({trig = "Sum", name = "sum" }, "\\sum_{$1}^{$2}$0"),
	parse({trig = "prod", name = "prod" }, "\\prod_{$1}$0"),
	parse({trig = "Prod", name = "Prod" }, "\\prod_{$1}^{$2}$0"),

	parse({ trig = "lim", name = "lim" }, "\\lim_{$1}$0 "),

	-- parse({trig = "mc", name = "Mathcal" }, "\\mathcal{$1}$0"),
	parse({trig = "set", name = "set" }, "\\{$1 \\\\}$0"),
	parse({trig = "abs", name = "abs" }, "|$1 |$0"),
}

for _, snip in ipairs(basic_math_ops_tab) do
    snip.condition = pipe({ is_math, no_backslash })
    snip.show_condition = is_math
    snip.wordTrig = false
	table.insert(tab_snippets,snip)
end

basic_math_ops_auto = {
	parse({trig = "lr(", name = "left right ()" }, "\\left($1\\right)$0"),
	parse({trig = "lr[", name = "left right []" }, "\\left[$1\\right]$0"),
	parse({trig = "lrg(", name = "left right {}" }, "\\left\\{$1 \\right\\\\}$0"),
	parse({trig = "lr|", name = "left right ||" }, "\\left|$1\\right|$0"),
	parse({trig = "lr<", name = "left right <>" }, "\\left<$1\\right>$0"),
	parse({trig = "lr{", name = "left right {}" }, "\\left\\{$1\\right\\\\}$0"),

	parse({trig = "ll(", name = "left (" }, "\\left($0"),
	parse({trig = "rr)", name = "right )" }, "\\right)$0"),
	parse({trig = "ll[", name = "left [" }, "\\left[$0"),
	parse({trig = "rr]", name = "right ]" }, "\\right]$0"),
	parse({trig = "llg(", name = "left {" }, "\\left\\{$0"),
	parse({trig = "rrg)", name = "right }" }, "\\right\\}$0"),



}
for _, snip in ipairs(basic_math_ops_auto) do
    snip.condition = pipe({  no_backslash })
    -- snip.show_condition = is_math
    snip.wordTrig = false
	table.insert(auto_snippets,snip)
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
