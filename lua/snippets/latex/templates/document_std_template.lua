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

-- Tab------------------
local document_template_tab  = {
	parse({trig = "latexdoc", name = "template for latex document"},
	[[
	% Preamble
	% Document Class
	\documentclass[11pt, oneside, headsepline=on, parskip=half, numbers=enddot, intlimits]{scrbook} % Explanation see below.
	% Format: Book, font size 11pt.
	% numbers=enddot adds point to section numbers.
	% Koma-Script:
	% parskip: No paragraph indent, instead a little white space between paragraphs.
	% headsepline adds a line for page headers

	% Basics
	\usepackage[T1]{fontenc} % Output encoding
	\usepackage[utf8]{inputenc}  % Input encoding
	\usepackage{lmodern} % High resolution font

	% Fonts and layout
	\usepackage{microtype} %  typesetting improvements
	\usepackage[bottom=2.5cm]{geometry} % not needed if the typearea style in Koma-Script is used
	\usepackage[onehalfspacing]{setspace} % Spacing
	\setlength{\skip\footins}{17pt} % Footnote separation from text
	\setkomafont{sectioning}{\normalfont\normalcolor\bfseries} % headings with serif
	\addtokomafont{descriptionlabel}{\normalfont\bfseries} % serifs for description labels
	\usepackage{scrlayer-scrpage}
	\usepackage{amsthm} % ams proof environments
	\usepackage{comment} % multiline comments
	\usepackage{aligned-overset} % Allows use of overset together with alignment ampersands
	\setcounter{secnumdepth}{2} % depth of section numbering
	\setcounter{tocdepth}{1} % depth of table of contents
	\RedeclareSectionCommand[tocnumwidth=10mm]{section} % page number alignment in table of contents
	\allowdisplaybreaks[1] % allows pagebreaks in display math. The [1] denotes that this is used sparingly.

	% Symbols
	\usepackage{mathtools} % also loads amsmath package
	\usepackage{amsmath} % also loads amsmath package
	\usepackage{amssymb} % more symbols
	\usepackage[svgnames, hyperref]{xcolor} % colors
	\usepackage{graphicx} % graphics
	\usepackage[all]{xy} % diagrams
	\usepackage[shortlabels]{enumitem} % better enumerations
	\usepackage{siunitx}
	\usepackage{todonotes}

	% Hyperlinks
	\usepackage[linktoc=page,colorlinks=true,linkcolor=Blue,citecolor=DarkGreen,urlcolor=Black]{hyperref}

	\theoremstyle{definition} % Standard environments
	\newtheorem*{de}{Definition}
	\newtheorem*{rem}{Remark}
	\newtheorem*{ex}{Example}

	\theoremstyle{plain} % cursive environments
	\newtheorem*{lem}{Lemma}
	\newtheorem*{thm}{Theorem}
	\newtheorem*{cor}{Corollary}

	% user-defined commands
	%\newcommand*{\setbuilder}[2]{\left\{ #1\mathrel{} : \mathrel{} \begin{aligned} #2 \end{aligned} \right}} % Set builder notation
	\newcommand*{\quotient}[2]{#1/_{#2}} % Quotients
	\newcommand*{\restrict}{\mathord{\mbox{\large $\upharpoonright$}}} % Restrictions
	\renewcommand*{\P}{\mathcal P} % Power Set

	\newcommand*{\discup}{\mathbin{\dot{\cup}}}  % disjoint unions
	\newcommand*{\disbigcup}{\mathop{\dot{\bigcup}}}
	\renewcommand*{\c}{\mathsf c} % Set complements
	\newcommand*{\im}{\operatorname{im}}  % Image
	\newcommand*{\id}{\operatorname{Id}}  % Identity
	\newcommand*{\sgn}{\operatorname{sgn}} % Sign function
	\renewcommand*{\d}{\mathop{}\!\mathrm{d}}  % differential d
	\newcommand*{\Dt}{\text{D}}  % differential d

	% numbers
	\newcommand*{\N}{\mathbb N}
	\newcommand*{\Z}{\mathbb Z}
	\newcommand*{\Q}{\mathbb Q}
	\newcommand*{\R}{\mathbb R}
	\newcommand*{\C}{\mathbb C}
	\newcommand*{\e}{{\textit{e}\mkern1mu}}  % Euler number
	\renewcommand*{\i}{\mathrm{{i\mkern1mu}}}  % imaginary unit
	\renewcommand*{\Re}{\operatorname{Re}} % Real and imaginary part
	\renewcommand*{\Im}{\operatorname{Im}}

	\let\originalleft\left % better spacing for \left and \right
	\let\originalright\right
	\renewcommand{\left}{\mathopen{}\mathclose\bgroup\originalleft}
	\renewcommand{\right}{\aftergroup\egroup\originalright}

	\makeatletter
	\newcommand{\DeclareSwappedPairedDelimiter}[3]{%
		\expandafter\DeclarePairedDelimiter\csname RIGHT\string#1\endcsname{#2}{#3}%
		\newcommand#1{%
			\@ifstar{\csname RIGHT\string#1\endcsname}
			{\@ifnextchar[{\csname RIGHT\string#1\endcsname}
				{\csname RIGHT\string#1\endcsname*}}}}
	\makeatother

	\DeclareSwappedPairedDelimiter{\abs}{\lvert}{\rvert} % absolute value and norm
	\DeclareSwappedPairedDelimiter{\norm}{\lVert}{\rVert}
	\DeclareSwappedPairedDelimiter{\inner}{\langle}{\rangle} % bracket

	% better 'bar' command
	\renewcommand*{\bar}{\overline}

	% bold variables
	\newcommand*{\x}{\mathbf x}
	\newcommand*{\y}{\mathbf y}
	\newcommand*{\z}{\mathbf z}
	\newcommand*{\p}{\mathbf p}
	\renewcommand*{\v}{\mathbf v}
	\newcommand*{\w}{\mathbf w}
	\renewcommand*{\b}{\mathbf b}
	\newcommand*{\nub}{\boldsymbol{\nu}}
	\newcommand*{\ee}{\mathbf e}

	% notation in Analysis
	\usepackage{esint} % Needed for mean integral sign.
	\newcommand*{\at}[2]{\left .#1 \right|_{#2}} % Derivative at a point
	\newcommand*{\subsub}{\subset\!\subset} % Compact containment
	\newcommand*{\supp}{\operatorname{supp}}
	\newcommand*{\del}{\partial}
	\newcommand*{\Hess}{\operatorname{Hess}}
	\newcommand*{\esssup}{\operatorname*{ess\,sup}}

	\newcommand*{\Lip}{\operatorname{Lip}}
	\newcommand*{\Lloc}{L_{\operatorname{loc}}} % Locally integrable
	\renewcommand*{\C}{\mathcal C}
	\renewcommand*{\div}{\operatorname{div}}
	\newcommand*{\dist}{\operatorname{dist}}

	% notation for Distribution Theory
	\newcommand*{\D}{\mathcal D} % Space of test functions
	\newcommand*{\PV}{\text{P.V. }} % Principal value
	\renewcommand*{\S}{\mathcal S} % Space of rapidly decaying functions
	\newcommand{\F}{\mathcal F} % Fourier transform

	%%%%%%%%%%

	\begin{document}

		\renewcommand*{\partpagestyle}{empty}

		\automark{section}
		\renewcommand*{\chapterpagestyle}{empty}
		\ihead{\rightmark}
		\chead{}
		\ohead{\pagemark}
		\ifoot{}
		\cfoot{}
		\ofoot{}

		\pagenumbering{Alph}

		\begin{titlepage}
			\centering
			\vspace*{4cm}
			{\huge\bfseries $1  \par}
			\vspace{2cm}
			{\Large Winter Term 2021/2022, Version of \today \par}
			\vspace{1cm}
			%\includegraphics[width=\textwidth]{Images/title_cosine}
			\vfill
		\end{titlepage}

		\pagenumbering{roman}
		\tableofcontents
		\cleardoubleoddpage
		\pagenumbering{arabic}

	\part{$2}
		$0,
	\\appendix,
	%\\begin{appendices},
	\\chapter{Appendix},
	%\\input{chapters/99.Appendix},
	%\\begin{thebibliography}{9},
	,
	%\\bibitem[Ev1]{Evans2010} Evans, Lawrence C, \\textit{Partial Differential Equations, Second Edition}, American Mathematical Society, 2010.,
	,
	%\\end{thebibliography},
	,
	\\end{document}
	]]),
}
for _, snip in ipairs(document_template_tab) do
	snip.wordTrig = false
	table.insert(tab_snippets,snip)
end

-- Auto -----------------
local document_template_auto  = {
}

for _, snip in ipairs(document_template_auto) do
	snip.condition = is_math--pipe({ is_math })
	snip.show_condition = is_math
	snip.wordTrig = false
	table.insert(auto_snippets,snip)
end

-- }})

ls.add_snippets("tex",tab_snippets, {
	default_priority = 0,
	key = "document_template_tab"
})

ls.add_snippets("tex",auto_snippets, {
	default_priority = 0,
	type = "autosnippets",
	key = "document_template_auto"
})
