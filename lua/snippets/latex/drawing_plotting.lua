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
	
-- There is a choice node in there! How?
local plot_tikz_tab  = {
	parse({trig = "plot", name = "plot"}, 
	[[
	\begin{figure}[$1]
		\centering
		\begin{tikzpicture}
			\begin{axis}[
				xmin= ${2:-10}, xmax= ${3:10},
				ymin= ${4:-10}, ymax = ${5:10},
				axis lines = middle,
			]
				\addplot[domain=$2:$3, samples=${6:100}]{$7};
			\end{axis}
		\end{tikzpicture}
		\caption{$8}
		\label{${9:$8}}
	\end{figure}
	]]),
	parse({trig = "tikn", name = "tikz node"}, "\\node[$5] (${1/[^0-9a-zA-Z]//g}${2}) ${3:at (${4:0,0}) }{$${1}$};"),
}

for _, snip in ipairs(plot_tikz_tab) do
    snip.wordTrig = false
	table.insert(tab_snippets,snip)
end

-- }})

ls.add_snippets("tex",auto_snippets, {
	default_priority = 0,
	type = "autosnippets",
	key = "drawing_plotting_auto"
})

ls.add_snippets("tex",tab_snippets, {
	default_priority = 0,
	key = "drawing_plotting_tab"
})


