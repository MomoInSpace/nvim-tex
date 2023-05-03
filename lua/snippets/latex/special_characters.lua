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
	parse({trig = "td", name = "to the" }, "^{$1} $0"),
	parse({trig = " td", name = "to the apart" }, "^{$1} $0"),
	parse({trig = "tq", name = "to the" }, "\\sqrt{$1} $0"),
	parse({trig = "ttq", name = "to the" }, "\\sqrt[$1]{$2} $0"),

	parse({trig = ";d", name = "down apart" }, "_{$1} $0"),
	parse({trig = " ;d", name = "down apart afar" }, "_{$1} $0"),
	parse({trig = ";t", name = "down apart" }, "_{\\text{$1}} $0"),
	parse({trig = " ;t", name = "down apart afar" }, "_{\\text{$1}} $0"),
	parse({trig = " ^", name = "up apart" }, "^$0"),
	parse({trig = "__", name = "down" }, "_{$1} $0"),
	parse({trig = " _", name = "down afar" }, "_"),
	parse({trig = "_T_", name = "down" }, "_{\\text{$1}} $0"),
	parse({trig = "**",name = 'Cdots'},"\\cdot"),

}

for key, snip in ipairs(basic_operators) do
	snip.priority = key + 1000
    snip.condition = pipe({ is_math, no_backslash })
    snip.show_condition = is_math
    snip.wordTrig = false
	table.insert(auto_snippets,snip)
end

word_trig_operators = {
	parse({trig = "xx",name = 'times'},"\\times"),

	parse({trig = "...",name = 'ldots'},"\\ldots"),
	parse({trig = "=>",name = 'implies'},"\\implies"),
	parse({trig = "<=",name = 'implied by'},"\\impliedby"),
	parse({trig = "<>",name = 'iff'},"\\iff"),
	parse({trig = "=n",name = 'unequals'},"\\not="),
	parse({trig = "=d",name = 'define'},"\\coloneqq"),
	parse({trig = "=!",name = 'overset'},"\\overset{${1:!}}{=}$0"),

	parse({trig = "<=",name = 'lower equal'},"\\le"),
	parse({trig = ">=",name = 'lower equal'},"\\ge"),
	parse({trig = ">>",name = 'gg'},"\\gg"),
	parse({trig = "<<",name = 'll'},"\\ll"),
	parse({trig = "o*",name = 'Verknuepfung'},"\\circ"),

	parse({trig = "~~",name = 'sim'},"\\sim"),
	parse({trig = "=s",name = 'sim2'},"\\sim"),

	parse({trig = "cc",name = 'subset'},"\\subset"),
	parse({trig = "qq",name = 'quad'},"\\quad"),
	parse({trig = "tto",name = 'to'},"\\to"),

	parse({trig = "->",name = 'to'},"\\to"),
	parse({trig = "too",name = 'to'},"\\to"),
	parse({trig = "dra",name = 'down to'},"\\searrow"),
	parse({trig = "ura",name = 'up to'},"\\nearrow"),
	parse({trig = "lra",name = 'leftrightarrow'},"\\leftrightarrow"),
	parse({trig = "Lra",name = 'Leftrightarrow'},"\\Leftrightarrow"),
	parse({trig = "mto",name = 'mapsto'},"\\mapsto"),

	parse({trig = "invs", name = "inverse" }, "^{-1}"),

	parse({trig = "OO", name = "Order" }, "\\mathcal{O}"),
	parse({trig = "oo", name = "Infty" }, "\\infty"),
	parse({trig = "00", name = "empty" }, "\\emptyset"),
	parse({trig = "RR", name = "R" }, "\\mathbb{R}"),
	parse({trig = "QQ", name = "Q" }, "\\mathbb{Q}"),
	parse({trig = "ZZ", name = "Z" }, "\\mathbb{Z}"),
	parse({trig = "NN", name = "C" }, "\\mathbb{N}"),
	parse({trig = "CC", name = "C" }, "\\mathbb{C}"),
	parse({trig = "UU", name = "cup" }, "\\cup "),
	parse({trig = "AA", name = "for all" }, "\\forall"),
	parse({trig = "Re", name = "Reynolds" }, "\\Re"),


	parse({trig = "||", name = "mid" }, " \\mid "),
	parse({trig = "Nn", name = "cap" }, "\\cap "),
	parse({trig = "cc", name = "subset" }, "\\subset "),
	parse({trig = "inn", name = "element of" }, "\\in "),


	parse({trig = "nabl", name = "nabla" }, "\\nabla$0"),

	parse({trig = "dd", name = "diff_d" }, "\\d "),
	parse({trig = "DD", name = "diff_D" }, "\\Dt "),
	parse({trig = "tt", name = "text" }, "\\text{$1} $0"),
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
	parse({ trig = "'*", name = "star" }, "\\star "),
	parse({ trig = "perp", name = "perp" }, "\\perp "),
	parse({ trig = "sup", name = "sup" }, "\\sup "),
	parse({ trig = "inf", name = "inf" }, "\\inf "),
	parse({ trig = "max", name = "max" }, "\\max "),
	parse({ trig = "min", name = "min" }, "\\min "),

	parse({ trig = "arcsin", name = "arcsin" }, "\\arcsin "),
	parse({ trig = "arctan", name = "arctan" }, "\\arctan "),
	parse({ trig = "arcsec", name = "arcsec" }, "\\arcsec "),

	parse({ trig = "asin", name = "asin" }, "\\arcsin "),
	parse({ trig = "atan", name = "atan" }, "\\arctan "),
	parse({ trig = "asec", name = "asec" }, "\\arcsec "),


}

for key, snip in ipairs(word_trig_operators) do
	snip.priority = key
    snip.condition = pipe({ is_math, no_backslash })
    snip.show_condition = is_math
    snip.wordTrig = true
	table.insert(auto_snippets,snip)
end

basic_operators_backslash = {
	parse({trig = "\\sim~",name = 'approx'},"\\approx"),
	parse({trig = "~2",name = 'approx'},"\\approx"),
	parse({trig = "pto",name = 'propto'},"\\propto"),
	parse({trig = "\\\\s",name = 'setminus'},"\\setminus"),
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
