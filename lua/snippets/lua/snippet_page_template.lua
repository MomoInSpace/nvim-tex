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

-- local utils = require("snippets.latex.util.utils")
--local ts_utils = require("snippets.latex.util.ts_utils")
--local pipe = utils.pipe
-- local is_math = utils.with_opts(utils.is_math, true)
-- local not_math = utils.with_opts(utils.not_math, true)
--local no_backslash = utils.no_backslash

local auto_snippets = {}
local tab_snippets = {}

--# Start of Snippets -----------------------------------------({{
	
	
-- There is a choice node in there! How?
local ls_template  = {
	parse({trig = "parse", name = "ls_parse"},"parse({trig = '$1', name = '$2'}, [[\n $0 \n]]),"),
	parse({trig = "parses", name = "short_parse"},
	[[
	parse({trig = "$1", name = "$2"},"$0"),
	]]),
	parse({trig = "lstemplate", name = "LuaSnipsTemplate"}, 
	[[
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
	$0
	-- Tab------------------
	local $1_tab  = {
		--parse({trig = "plot", name = "plot"}, 
		--[[
		--
		--\]\]
	}
	for _, snip in ipairs($1_tab) do
		snip.wordTrig = false
		table.insert(tab_snippets,snip)
	end

	-- Auto -----------------
	[[
	local $1_auto  = {
	}

	for _, snip in ipairs($1_auto) do
		snip.condition = is_math--pipe({ is_math })
		snip.show_condition = is_math
		snip.wordTrig = false
		table.insert(auto_snippets,snip)
	end
	\]\]
	-- }})

	ls.add_snippets("tex",tab_snippets, {
		default_priority = 0,
		key = "$2_tab"
	})
	\[\[
	ls.add_snippets("tex",auto_snippets, {
		default_priority = 0,
		type = "autosnippets",
		key = "$2_auto"
	})
	\]\]
	]]),
}

for _, snip in ipairs(ls_template) do
    snip.wordTrig = false
	table.insert(tab_snippets,snip)
end

-- }})

ls.add_snippets("lua",tab_snippets, {
	default_priority = 0,
	key = "snippet_page_template_tab"
})


