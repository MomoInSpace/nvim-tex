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
basic_operators = {	
	parse({trig = "**",name = 'Cdots'},"\\cdot"),
	parse({trig = "xx",name = 'times'},"\\times"),

	parse({trig = "...",name = 'ldots'},"\\ldots"),
	parse({trig = "=>",name = 'implies'},"\\implies"),
	parse({trig = "<=",name = 'implied by'},"\\impliedby"),
	parse({trig = "iff",name = 'iff'},"\\iff"),
	parse({trig = "=n",name = 'unequals'},"\\not="),
	parse({trig = "=d",name = 'define'},"\\coloneqq"),
	parse({trig = "<=",name = 'lower equal'},"\\le"),
	parse({trig = ">=",name = 'lower equal'},"\\ge"),
	parse({trig = ">>",name = 'gg'},"\\gg"),
	parse({trig = "<<",name = 'll'},"\\ll"),
	
	parse({trig = "~~",name = 'sim'},"\\sim"),
	parse({trig = "=s",name = 'sim2'},"\\sim"),

	parse({trig = "cc",name = 'subset'},"\\subset"),
	parse({trig = "qq",name = 'quad'},"\\quad"),
	parse({trig = "tto",name = 'to'},"\\to"),
	parse({trig = "->",name = 'to'},"\\to"),
	parse({trig = "lra",name = 'leftrightarrow'},"\\leftrightarrow"),
	parse({trig = "Lra",name = 'Leftrightarrow'},"\\Leftrightarrow"),
	parse({trig = "mto",name = 'mapsto'},"\\mto"),
	parse({trig = "invs", name = "inverse" }, "^{-1}"),
	parse({trig = "OO", name = "emptyset" }, "\\O"),
	parse({trig = "RR", name = "R" }, "\\mathbb{R}"),
	parse({trig = "QQ", name = "Q" }, "\\mathbb{Q}"),
	parse({trig = "ZZ", name = "Z" }, "\\mathbb{Z}"),
	parse({trig = "NN", name = "C" }, "\\mathbb{N}"),
	parse({trig = "CC", name = "C" }, "\\mathbb{C}"),
	parse({trig = "UU", name = "cup" }, "\\cup "),
	parse({trig = "||", name = "mid" }, " \\mid "),
	parse({trig = "Nn", name = "cap" }, "\\cap "),
	parse({trig = "cc", name = "subset" }, "\\subset "),
	
	parse({trig = "nabl", name = "nabla" }, "\\nabla$0"),

	parse({trig = "dd", name = "diff_d" }, "\\d "),
	parse({trig = "td", name = "to the" }, "^{$1} $0"),
	parse({trig = "__", name = "down" }, "_{$1} $0"),
	parse({trig = "tt", name = "text" }, "\\text{$1} $0"),
	parse({trig = "Dif", name = "" }, "\\frac{D$1}{D$2} $0"),
	parse({trig = "dif", name = "text" }, "\\frac{\\d$1}{\\d$2} $0"),
	parse({trig = "part", name = "partial" }, "\\frac{\\partial$1}{\\partial$2} $0"),
	parse({trig = "del", name = "partial" }, "\\partial $0"),


	parse({ trig = "sin", name = "sin" }, "\\sin "),
	parse({ trig = "cos", name = "cos" }, "\\cos "),
	parse({ trig = "tan", name = "tan" }, "\\tan "),
	parse({ trig = "sec", name = "sec" }, "\\sec "),
	parse({ trig = "csc", name = "csc" }, "\\csc "),
	parse({ trig = "cot", name = "cot" }, "\\cot "),
	parse({ trig = "ln", name = "ln" }, "\\ln "),
	parse({ trig = "log", name = "log" }, "\\log "),
	parse({ trig = "exp", name = "exp" }, "\\exp "),
	parse({ trig = "star", name = "star" }, "\\star "),
	parse({ trig = "perp", name = "perp" }, "\\perp "),
	parse({ trig = "int", name = "int" }, "\\int "),

	parse({ trig = "arcsin", name = "arcsin" }, "\\arcsin "),
	parse({ trig = "arctan", name = "arctan" }, "\\arctan "),
	parse({ trig = "arcsec", name = "arcsec" }, "\\arcsec "),

	parse({ trig = "asin", name = "asin" }, "\\arcsin "),
	parse({ trig = "atan", name = "atan" }, "\\arctan "),
	parse({ trig = "asec", name = "asec" }, "\\arcsec "),



} 

for _, snip in ipairs(basic_operators) do
    snip.condition = pipe({ is_math, no_backslash })
    snip.show_condition = is_math
    snip.wordTrig = false
	table.insert(auto_snippets,snip)
end

basic_operators_backslash = {	
	parse({trig = "\\sims",name = 'approx'},"\\approx"),
}

for _, snip in ipairs(basic_operators_backslash) do
    snip.condition = pipe({ is_math })
    snip.show_condition = is_math
    snip.wordTrig = false
	table.insert(auto_snippets,snip)
end

-- }})


-- # greek letters------------------------------------({{
local greek_letters =  {
	-- alpha------------
	s("'a", {
	  t({ '\\alpha' }),
	}),
	--Alpha------------
	s("'A", {
	  t( '\\Alpha'),
	}),
	--beta------------
	s("'b", {
	  t({ '\\beta' }),
	}),
	--Beta------------
	s("'B", {
	  t({ '\\Beta' }),
	}),
	--chi------------
	s("'ch", {
	  t({ '\\chi' }),
	}),
	--Chi------------
	s("'Ch", {
	  t({ '\\Chi' }),
	}),
	--delta------------
	s("'d", {
	  t({ '\\delta' }),
	}),
	--Delta------------
	s("'D", {
	  t({ '\\Delta' }),
	}),
	--epsilon------------
	s("'ep", {
	  t({ '\\epsilon' }),
	}),
	--Epsilon------------
	s("'Ep", {
	  t({ '\\Epsilon' }),
	}),
	--varepsilon------------
	s("'vep", {
	  t({ '\\varepsilon' }),
	}),
	--eta------------
	s("'et", {
	  t({ '\\eta' }),
	}),
	--gamma------------
	s("'y", {
	  t({ '\\gamma' }),
	}),
	--Gamma------------
	s("'Y", {
	  t({ '\\Gamma' }),
	}),
	--iota------------
	s("'i", {
	  t({ '\\iota' }),
	}),
	--Iota------------
	s("'I", {
	  t({ '\\Iota' }),
	}),
	--kappa------------
	s("'k", {
	  t({ '\\kappa' }),
	}),
	--Kappa------------
	s("'K", {
	  t({ '\\Kappa' }),
	}),
	--lambda------------
	s("'l", {
	  t({ '\\lambda' }),
	}),
	--Lambda------------
	s("'L", {
	  t({ '\\Lambda' }),
	}),
	--mu------------
	s("'m", {
	  t({ '\\mu' }),
	}),
	--Mu------------
	s("'M", {
	  t({ '\\Mu' }),
	}),
	--nu------------
	s("'n", {
	  t({ '\\nu' }),
	}),
	--Nu------------
	s("'N", {
	  t({ '\\Nu' }),
	}),
	--omega------------
	s("'w", {
	  t({ '\\omega' }),
	}),
	--Omega------------
	s("'W", {
	  t({ '\\Omega' }),
	}),
	--phi------------
	s("'ph", {
	  t({ '\\phi' }),
	}),
	--Phi------------
	s("'Ph", {
	  t({ '\\Phi' }),
	}),
	--varphi------------
	s("'vph", {
	  t({ '\\varphi' }),
	}),
	--pi------------
	s("pi", {
	  t({ '\\pi' }),
	}),
	--Pi------------
	s("Pi", {
	  t({ '\\Pi' }),
	}),
	--psi------------
	s("'ps", {
	  t({ '\\psi' }),
	}),
	--Psi------------
	s("'Ps", {
	  t({ '\\Psi' }),
	}),
	--rho------------
	s("'rh", {
	  t({ '\\rho' }),
	}),
	--Rho------------
	s("'Rh", {
	  t({ '\\Rho' }),
	}),
	--varrho------------
	s("'vr", {
	  t({ '\\varrho' }),
	}),
	--Varrho------------
	s("'Vr", {
	  t({ '\\Varrho' }),
	}),
	--sigma------------
	s("'si", {
	  t({ '\\sigma' }),
	}),
	--Sigma------------
	s("'Si", {
	  t({ '\\Sigma' }),
	}),
	--tau------------
	s("'ta", {
	  t({ '\\tau' }),
	}),
	--Tau------------
	s("'Ta", {
	  t({ '\\Tau' }),
	}),
	--theta------------
	s("'th", {
	  t({ '\\theta' }),
	}),
	--Theta------------
	s("'Th", {
	  t({ '\\Theta' }),
	}),
	--vartheta------------
	s("'vth", {
	  t({ '\\vartheta' }),
	}),
	--xi------------
	s("'x", {
	  t({ '\\xi' }),
	}),
	--Xi------------
	s("'X", {
	  t({ '\\Xi' }),
	}),
	--zeta------------
	s("'z", {
	  t({ '\\zeta' }),
	}),
	--Zeta------------
	s("'Z", {
	  t({ '\\Zeta' }),
	})
}

for _, snip in ipairs(greek_letters) do
    snip.condition = is_math--pipe({ is_math })
    snip.show_condition = is_math
    snip.wordTrig = false
	table.insert(auto_snippets,snip)
end

-- }})


-- }})



ls.add_snippets("tex",auto_snippets, {
	default_priority = 0,
	type = "autosnippets",
	key = "special_characters_auto"
})

ls.add_snippets("tex",tab_snippets, {
	default_priority = 0,
	key = "special_characters_tab"
})
