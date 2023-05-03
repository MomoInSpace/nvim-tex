-- # vim: foldmethod=marker
-- # vim: foldmarker=({{,}})

-- some shorthands...
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
--local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
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


--# math environments -----------------------------------------({{

-- function for recursive snippets:
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

local rec_align
rec_align = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({""}),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil,{t({"","\t\t"}), i(1),t(" &= "), i(2), t("\\\\"), d(3, rec_align, {})}),
		}),
	});
end

local math_envs_tab = {
	-- Begin/End
	parse({trig = "beg", name = "begin_env"},
	[[
	\\begin{$1}
		$2
	\\end{$1} $0
	]]),
	-- Equation
	parse({trig = "equ", name = "begin_equation"},
	[[
	\\begin{equation}
		$1
		\\label{eq_$2}
	\\end{equation} $0
	]]),
	-- Aligned
	parse({trig = "ali", name = "begin_align*"},
	[[
	\\begin{aligned}
		$1
	\\end{aligned} $0
	]]),
	-- Aligne*
	parse({trig = "alis", name = "begin_align*"},
	[[
	\\begin{align*}
		$1
	\\end{align*} $0
	]]),
	-- Equation Aligned
	parse({trig = "ale", name = "begin_equation_aligned"},
	[[
	\\begin{equation}
		\\begin{aligned}
			$1
		\\end{aligned}
		\\label{eq_$2}
	\\end{equation}$0
	]]),
	-- \label:
	parse({trig = "lab", name = "label"}, "\\label{$1}$0"),
	-- figure
	parse({trig = "fig", name = "figure"},
	[[
	\begin{figure}[${1:htpb}]
		\centering
		\includegraphics[width=0.8\textwidth]{$2}
		\caption{$3}
		\label{fig_$4}
	\end{figure} $0
	]]),
	parse({trig = "figs", name = "figure"},
	[[
	\begin{figure}[${1:htpb}]
		\centering
		$2
		\hfill
		$3
		\caption{$4}
		\label{fig_$5}
	\end{figure} $0
	]]),
	parse({trig = "subfig", name = "subfigure"},
	[[
     \begin{subfigure}[b]{0.49\textwidth}
	\centering
	\includegraphics[width=1\textwidth]{$1}
	\caption{$2}
	\label{fig_sub_$3}
     \end{subfigure} $0
	]]),
	-- list
	s("ls", {
	t({"\\begin{itemize}",
	"\t\\item "}), i(1), d(2, rec_ls, {}),
	t({"", "\\end{itemize}"}), i(0)
	}),
	-- enumerate
	s("enum", {
	t({"\\begin{enumerate}"}),
	c(1, {
		t(''),
		t('[a)]'),
		t('[I)]'),
		{t('['),i(1),t(']')},
	}),
	t({"","\t\\item "}), i(2), d(3, rec_ls, {}),
	t({"", "\\end{enumerate}"}), i(0)
	}),
	-- enumerate
	s("eac", {
	t({"\\begin{equation}"}),
	t({"","\t\\begin{aligned}"}),
	t({"","\t\t"}), i(1),t(" &= "), i(2), t("\\\\"), d(3, rec_align, {}),
	t({"","\t\\end{aligned}"}),
	t({"","\t\\label{eq_"}),i(4),t({"}"}),
	t({"", "\\end{equation}"}), i(0)
	}),
}

for _, snip in ipairs(math_envs_tab) do
    snip.wordTrig = true
	table.insert(tab_snippets,snip)
end


local math_envs_auto = {
	parse({trig = "mk",name = "inline_math"}, "\\$$1\\$"),
}

for _, snip in ipairs(math_envs_auto) do
    snip.condition = not_math--pipe({ is_math })
    snip.show_condition = not_math
    snip.wordTrig = true
	table.insert(auto_snippets,snip)
end

-- }})

--# Theorems -----------------------------------------({{

local theorems_tab = {
	parse({trig = "de", name = "Defintion"},"\\begin{de}[$1]\n $2 \n\\label{de_$1}\n\\end{de}\n$0"),
	parse({trig = "rem", name = "Remark"},"\\begin{rem}[$1]\n $2 \n\\label{rem_$1}\n\\end{rem}\n$0"),
	parse({trig = "ex", name = "Example"},"\\begin{ex}[$1]\n $2 \n\\label{ex_$1}\n\\end{ex}\n$0"),

	parse({trig = "lem", name = "Lemma"},"\\begin{lem}[$1]\n $2 \n\\label{lem_$1}\n\\end{lem}\n$0"),
	parse({trig = "thm", name = "Theorem"},"\\begin{thm}[$1]\n $2 \n\\label{thm_$1}\n\\end{thm}\n$0"),
	parse({trig = "cor", name = "Corollary"},"\\begin{cor}[$1]\n $2 \n\\label{cor_$1}\n\\end{cor}\n$0"),

}

for key, snip in ipairs(theorems_tab)  do
	snip.priority = key
    snip.wordTrig = false
	table.insert(tab_snippets,snip)
end
-- }})

--# sections -----------------------------------------({{

local sections_tab = {
	parse({trig = "part", name = "part"},"\\part{$1}\n$0"),
	parse({trig = "chap", name = "chapter"},"\\chapter{$1}\n$0"),
	parse({trig = "sec", name = "section"},"\\section{$1}\n$0"),
	parse({trig = "sub", name = "subsection"},"\\subsection{$1}\n$0"),
	parse({trig = "sub2", name = "subsubsection"},"\\subsubsection{$1}\n$0"),

	parse({trig = "part*", name = "part"},"\\part*{$1}\n$0"),
	parse({trig = "chap*", name = "chapter"},"\\chapter*{$1}\n$0"),
	parse({trig = "sec*", name = "section"},"\\section*{$1}\n$0"),
	parse({trig = "sub*", name = "subsection"},"\\subsection*{$1}\n$0"),
	parse({trig = "sub2*", name = "subsubsection"},"\\subsubsection*{$1}\n$0"),
}

for key, snip in ipairs(sections_tab) do
	snip.priority = key
    snip.wordTrig = false
	table.insert(tab_snippets,snip)
end
-- }})

--# Textblocks -----------------------------------------({{

local text_snippets_tab = {
	-- emphasize
	parse({trig = "emp", name = "emphasize"},"\\emph{$1}$0"),
	-- textbf
	parse({trig = "bf", name = "textbf"},"\\textbf{$1}$0"),
	parse({trig = "ref", name = "ref"},"\\ref{$1}$0"),
	parse({trig = "eqr", name = "ref equation"},"\\eqref{eq_$1}$0"),
}

for key, snip in ipairs(text_snippets_tab) do
	snip.priority = key
    snip.wordTrig = false
	table.insert(tab_snippets,snip)
end
-- }})

-- }})


ls.add_snippets("tex",auto_snippets, {
	default_priority = 0,
	type = "autosnippets",
	key = "environments_auto"
})

ls.add_snippets("tex",tab_snippets, {
	default_priority = 0,
	key = "environments_tab"
})
