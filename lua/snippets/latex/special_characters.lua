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
basic_operators = {	
	-- Cdots------------
	s("**", {
		t({ '\\cdot' }),
	}),
	-- ldots------------
	s("...", {
		t({ '\\ldots' }), }),
	-- implies------------
	s("=>", {
		t({ '\\implies' }),
	}),
	-- implied by------------
	s("<=", {
		t({ '\\impliedby' }),
	}),
	-- iff------------
	s("iff", {
		t({ '\\iff' }),
	}),
	-- unequals------------
	s("=n", {
		t({ '\\unequals' }),
	}),
	-- define------------
	s("=d", {
		t({ '\\coloneqq' }),
	}),
	-- lower equal------------
	s("<=", {
		t({ '\\le' }),
	}),
	-- lower equal------------
	s(">=", {
		t({ '\\ge' }),
	}),
	-- gg------------
	s(">>", {
		t({ '\\gg' }),
	}),
	-- ll-----------
	s("<<", {
		t({ '\\ll' }),
	}),
	-- sim-----------
	s("~~", {
		t({ '\\sim' }),
	}),
	-- subset-----------
	s("cc", {
		t({ '\\subset' }),
	}),
	-- quad------------
	s("qq", {
		t({ '\\quad' }),
	}),
	-- to------------
	s("tto", {
		t({ '\\to' }),
	}),
	-- to------------
	s("->", {
		t({ '\\to' }),
	}),
	-- leftrightarrow------------
	s("lra", {
		t({ '\\leftrightarrow' }),
	}),
	-- Leftrightarrow------------
	s("Lra", {
		t({ '\\Leftrightarrow' }),
	}),
	-- mapsto------------
	s("mto", {
		t({ '\\mto' }),
	}),
} 

for _, snip in ipairs(basic_operators) do
    snip.condition = is_math--pipe({ is_math })
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
	s("'p", {
	  t({ '\\psi' }),
	}),
	--Psi------------
	s("'P", {
	  t({ '\\Psi' }),
	}),
	--rho------------
	s("'r", {
	  t({ '\\rho' }),
	}),
	--Rho------------
	s("'R", {
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
	s("'s", {
	  t({ '\\sigma' }),
	}),
	--Sigma------------
	s("'S", {
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
