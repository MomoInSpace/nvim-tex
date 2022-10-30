-- # vim: foldmethod=marker
-- # vim: foldmarker=({{,}})

-- some shorthands...
local ls = require("luasnip")
local s = ls.snippet
--local sn = ls.snippet_node
local t = ls.text_node
--local i = ls.insert_node
local f = ls.function_node
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
--local no_backslash = utils.no_backslash

local auto_snippets = {}
local tab_snippets = {}

--# Start of Snippets -----------------------------------------({{

local vec_node = {
  f(function(_, snip)
    return string.format("\\overrightarrow{%s}", snip.captures[1])
  end, {}),
}

local hat_node = {
  f(function(_, snip)
    return string.format("\\hat{%s}", snip.captures[1])
  end, {}),
}

local bar_node = {
  f(function(_, snip)
    return string.format("\\overline{%s}", snip.captures[1])
  end, {}),
}

local ff_node = {
  f(function(_, snip)
    return string.format("\\mathbf{%s}", snip.captures[1])
  end, {}),
}

local brace_node = {
  f(function(_, snip)
    return string.format("\\ubrace{%s}", snip.captures[1])
  end, {}),
}

local bold_node = {
  f(function(_, snip)
    return string.format("\\boldsymbol %s", snip.captures[1])
  end, {}),
}

local nodearray = 	{vec_node, hat_node, bar_node, ff_node, brace_node, bold_node}
local trigarray = 	{"vec", "hat", "bar", "ff", "ubrace", "bold"}
modyfier_auto = {}


for key, node in pairs(nodearray) do
	regex_strings = {
		"([%a]+)",
		"(\\[%a]+[%{]?[%w]+[%}]?)",
		"%(([%a,%\\]+)%)"
	}

	for regKey, trigString in pairs(regex_strings) do

		local trigger = trigString..trigarray[key]
		node_double_char = s({ trig = trigger}, vim.deepcopy(node))
		table.insert(modyfier_auto,node_double_char)
	end
end


--local modyfier_tab = {
--s({ trig = "([%a][%a])(%.,)" }, vim.deepcopy(vec_node)),
--s({ trig = "([%a][%a])(,%.)" }, vim.deepcopy(vec_node)),
--s({ trig = "([%a])(%.,)" }, vim.deepcopy(vec_node)),
--s({ trig = "([%a])(,%.)" }, vim.deepcopy(vec_node)),
--}

for key, snip in ipairs(modyfier_auto) do
	snip.priority = key
    snip.regTrig = true
	snip.condition = pipe({is_math, no_backslash})
	table.insert(auto_snippets,snip)
end

-- }})

ls.add_snippets("tex",auto_snippets, {
	--default_priority = 0,
	type = "autosnippets",
	key = "modyfier_auto"
})

ls.add_snippets("tex",tab_snippets, {
	default_priority = 0,
	key = "modyfier_tab"
})


