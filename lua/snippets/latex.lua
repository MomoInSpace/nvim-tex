-- # vim: foldmethod=marker
-- # vim: foldmarker=({{,}})

-- some shorthands...
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")


ls.add_snippets("tex", {
	s("blabla", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
	}),
	s("trigger", {
		t({"After expanding, the cursor is here ->"}), i(1),
		t({"", "After jumping forward once, cursor is here ->"}), i(2),
		t({"", "After jumping once more, the snippet is exited there ->"}), i(0),
	})	
})

-- Environment: ---------------------------------------------------------------------
local tex = {}

-- DOESN'T WORK	!
tex.in_mathzone = function()
		--print(vim.fn['vimtex#syntax#in_mathzone']() == 1)
    	--return vim.eval('vimtex#syntax#in_mathzone()') == '1'
        return false --vim.fn['vimtex#syntax#in_mathzone']() == 0
end
tex.in_text = function()
        return not tex.in_mathzone()
end

-- print(tex.in_mathzone())

-- Use as follows:
-- s("dm", {
-- 	t({ "\\[", "\t" }),
-- 	i(1),
-- 	t({ "", "\\]" }),
-- }, { condition = tex.in_text })
-- pair("$","$",neg, char_count_same),

-- Latex Environments:

ls.add_snippets("tex",{
	s("dm", {
		t({ "\\[", "\t" }),
		i(1),
		t({ "", "\\]" }),
	}, { condition = tex.in_text }),
})


ls.add_snippets("tex", {
	s("mk", {
		t({"$"}),
		i(1),
		t({"$"}),
	}),
}, { 	type = "autosnippets",
	key = "Math_Env_Auto",
	condition = tex.in_text,
})



-- Math Operations Etc.: -----------------------------------------------------------------------({{

-- Basics operators: -----------------------------------------------------------------------({{
ls.add_snippets("tex", {
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
}, { 	type = "autosnippets",
	key = "math operations",
	condition = tex.in_mathzone(),
})

--}})


-- Easy-Jump-Ops: -----------------------------------------------------------------------({{
ls.add_snippets("tex", {
	-- Overbar------------
	s("obar", {
		t({ '\\overline{' }),
		i(1),
		t({ '}' }),
	}),
	-- Mean------------
	s("absV", {
	t({"\\left"}),
	c(1, {
		sn(nil, {
			t({"|"}),
			i(1),
			t({"\\right|"}),
		}),
		sn(nil,{
			t({"||"}),
			i(1),
			t({"\\right||"}),
		}),
	}),
	i(0),
	}),
}, { 	type = "autosnippets",
	key = "easy jump math ops",
	condition = tex.in_mathzone(),
})

--}})


-- Left-Right: -----------------------------------------------------------------------({{
ls.add_snippets("tex", {
	-- <>------------
	s("lr<", {
		t({ '\\left<' }),
		i(1),
		t({ '\\right>' }),
	}),
	-- ()------------
	s("lr(", {
		t({ '\\left(' }),
		i(1),
		t({ '\\right)' }),
	}),
	-- []------------
	s("lr[", {
		t({ '\\left[' }),
		i(1),
		t({ '\\right]' }),
	}),
	-- {}------------
	s("lr{", {
		t({ '\\left{' }),
		i(1),
		t({ '\\right}' }),
	}),
}, { 	type = "autosnippets",
	key = "left-right",
	condition = tex.in_mathzone(),
})

--}})

--}})


-- Lists Etc.: -----------------------------------------------------------------------({{
local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({""}),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, {t({"", "\t\\item "}), i(1), d(2, rec_ls, {})}),
		}),
	});
end

ls.add_snippets("tex",{
	s("ls", {
	t({"\\begin{itemize}",
	"\t\\item "}), i(1), d(2, rec_ls, {}),
	t({"", "\\end{itemize}"}), i(0)
}),
})


ls.add_snippets("tex",{
	s("enum", {
	t({"\\begin{enumerate}"}),
	c(1, {
		t(''),
		t('[label=\\alph*)]'),
		t('label=\\roman*)]'),
	}),
	t({"","\t\\item "}), i(2), d(3, rec_ls, {}),
	t({"", "\\end{enumerate}"}), i(0)
}),
})
--}})


-- Greek Letters:-------------------------------------------------------------------({{

-- Fast Notation:
-- ls.add_snippets("tex", {
-- 	s("'a", {
-- 		t("\\alpha"),
-- 	}),
-- 	s("'b",{
-- 		t("\\beta"),
-- 	})
-- }, {
-- 	type = "autosnippets",
-- 	key = "all_auto",
-- 	condition = tex.in_text,
-- })

-- # Fast Notation------------------------------------({{
ls.add_snippets("tex", {
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
	s("'w", {
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
	}),
	s("abc", {
		t({ '$' }),
		i(1),
		t({'$'}),
	}),
}, { 	type = "autosnippets",
	key = "all_auto",
	condition = tex.in_mathzone(),
})
-- }})

-- Slow Notation ------------------------------------------({{
ls.add_snippets("tex",{
	-- s("dm", {
	-- 	t({ "\\[", "\t" }),
	-- 	i(1),
	-- 	t({ "", "\\]" }),
	-- }, { condition = tex.in_text }),

	--alpha------------
	s('alpha', {
			t({ '\\alpha' }),
	},{ condition = tex.in_mathzone() }),

	--Alpha------------
	s('Alpha', {
			t({ '\\Alpha' }),
	},{ condition = tex.in_mathzone() }),

	--beta------------
	s('beta', {
			t({ '\\beta' }),
	},{ condition = tex.in_mathzone() }),

	--Beta------------
	s('Beta', {
			t({ '\\Beta' }),
	},{ condition = tex.in_mathzone() }),

	--chi------------
	s('chi', {
			t({ '\\chi' }),
	},{ condition = tex.in_mathzone() }),

	--Chi------------
	s('Chi', {
			t({ '\\Chi' }),
	},{ condition = tex.in_mathzone() }),

	--delta------------
	s('delta', {
			t({ '\\delta' }),
	},{ condition = tex.in_mathzone() }),

	--Delta------------
	s('Delta', {
			t({ '\\Delta' }),
	},{ condition = tex.in_mathzone() }),

	--epsilon------------
	s('epsilon', {
			t({ '\\epsilon' }),
	},{ condition = tex.in_mathzone() }),

	--Epsilon------------
	s('Epsilon', {
			t({ '\\Epsilon' }),
	},{ condition = tex.in_mathzone() }),

	--varepsilon------------
	s('varepsilon', {
			t({ '\\varepsilon' }),
	},{ condition = tex.in_mathzone() }),

	--eta------------
	s('eta', {
			t({ '\\eta' }),
	},{ condition = tex.in_mathzone() }),

	--gamma------------
	s('gamma', {
			t({ '\\gamma' }),
	},{ condition = tex.in_mathzone() }),

	--Gamma------------
	s('Gamma', {
			t({ '\\Gamma' }),
	},{ condition = tex.in_mathzone() }),

	--iota------------
	s('iota', {
			t({ '\\iota' }),
	},{ condition = tex.in_mathzone() }),

	--Iota------------
	s('Iota', {
			t({ '\\Iota' }),
	},{ condition = tex.in_mathzone() }),

	--kappa------------
	s('kappa', {
			t({ '\\kappa' }),
	},{ condition = tex.in_mathzone() }),

	--Kappa------------
	s('Kappa', {
			t({ '\\Kappa' }),
	},{ condition = tex.in_mathzone() }),

	--lambda------------
	s('lambda', {
			t({ '\\lambda' }),
	},{ condition = tex.in_mathzone() }),

	--Lambda------------
	s('Lambda', {
			t({ '\\Lambda' }),
	},{ condition = tex.in_mathzone() }),

	--mu------------
	s('mu', {
			t({ '\\mu' }),
	},{ condition = tex.in_mathzone() }),

	--Mu------------
	s('Mu', {
			t({ '\\Mu' }),
	},{ condition = tex.in_mathzone() }),

	--nu------------
	s('nu', {
			t({ '\\nu' }),
	},{ condition = tex.in_mathzone() }),

	--Nu------------
	s('Nu', {
			t({ '\\Nu' }),
	},{ condition = tex.in_mathzone() }),

	--omega------------
	s('omega', {
			t({ '\\omega' }),
	},{ condition = tex.in_mathzone() }),

	--Omega------------
	s('Omega', {
			t({ '\\Omega' }),
	},{ condition = tex.in_mathzone() }),

	--phi------------
	s('phi', {
			t({ '\\phi' }),
	},{ condition = tex.in_mathzone() }),

	--Phi------------
	s('Phi', {
			t({ '\\Phi' }),
	},{ condition = tex.in_mathzone() }),

	--varphi------------
	s('varphi', {
			t({ '\\varphi' }),
	},{ condition = tex.in_mathzone() }),

	--pi------------
	s('pi', {
			t({ '\\pi' }),
	},{ condition = tex.in_mathzone() }),

	--Pi------------
	s('Pi', {
			t({ '\\Pi' }),
	},{ condition = tex.in_mathzone() }),

	--psi------------
	s('psi', {
			t({ '\\psi' }),
	},{ condition = tex.in_mathzone() }),

	--Psi------------
	s('Psi', {
			t({ '\\Psi' }),
	},{ condition = tex.in_mathzone() }),

	--rho------------
	s('rho', {
			t({ '\\rho' }),
	},{ condition = tex.in_mathzone() }),

	--Rho------------
	s('Rho', {
			t({ '\\Rho' }),
	},{ condition = tex.in_mathzone() }),

	--varrho------------
	s('varrho', {
			t({ '\\varrho' }),
	},{ condition = tex.in_mathzone() }),

	--Varrho------------
	s('Varrho', {
			t({ '\\Varrho' }),
	},{ condition = tex.in_mathzone() }),

	--sigma------------
	s('sigma', {
			t({ '\\sigma' }),
	},{ condition = tex.in_mathzone() }),

	--Sigma------------
	s('Sigma', {
			t({ '\\Sigma' }),
	},{ condition = tex.in_mathzone() }),

	--tau------------
	s('tau', {
			t({ '\\tau' }),
	},{ condition = tex.in_mathzone() }),

	--Tau------------
	s('Tau', {
			t({ '\\Tau' }),
	},{ condition = tex.in_mathzone() }),

	--theta------------
	s('theta', {
			t({ '\\theta' }),
	},{ condition = tex.in_mathzone() }),

	--Theta------------
	s('Theta', {
			t({ '\\Theta' }),
	},{ condition = tex.in_mathzone() }),

	--vartheta------------
	s('vartheta', {
			t({ '\\vartheta' }),
	},{ condition = tex.in_mathzone() }),

	--xi------------
	s('xi', {
			t({ '\\xi' }),
	},{ condition = tex.in_mathzone() }),

	--Xi------------
	s('Xi', {
			t({ '\\Xi' }),
	},{ condition = tex.in_mathzone() }),

	--zeta------------
	s('zeta', {
			t({ '\\zeta' }),
	},{ condition = tex.in_mathzone() }),

	--Zeta------------
	s('Zeta', {
			t({ '\\Zeta' }),
	},{ condition = tex.in_mathzone() }),

s("test_dm", {
	t({ "\\[", "\t" }),
	i(1),
	t({ "", "\\]" }),
}, { condition = false })

})
-- }})
--}})

-- My Latex Template:
-- ls.add_snippets("tex",{
-- 	s("latexTemplate", {
-- 		t({ [[testtesttest]] }),
-- 	}),
-- })


-- Deprecated: -------------------------------------------------


-- ls.add_snippets("tex", {
-- 	-- Very long example for a java class.
-- 	s("enumtest", {
-- 		d(6, jdocsnip, { 2, 4, 5 }),
-- 		t({ "", "" }),
-- 		c(1, {
-- 			t("public "),
-- 			t("private "),
-- 		}),
-- 		c(2, {
-- 			t("void"),
-- 			t("String"),
-- 			t("char"),
-- 			t("int"),
-- 			t("double"),
-- 			t("boolean"),
-- 			i(nil, ""),
-- 		}),
-- 		t(" "),
-- 		i(3, "myFunc"),
-- 		t("("),
-- 		i(4),
-- 		t(")"),
-- 		c(5, {
-- 			t(""),
-- 			sn(nil, {
-- 				t({ "", " throws " }),
-- 				i(1),
-- 			}),
-- 		}),
-- 		t({ " {", "\t" }),
-- 		i(0),
-- 		t({ "", "}" }),
-- 	}),
-- }, {
-- 	key = "java",
-- })


