--Make relative line numbers default. 
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode.
vim.o.mouse = 'a'

-- Enable break indent.
vim.o.breakindent = true

-- Set tab length to 4 spaces.
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Save undo history.
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time.
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end

  " Uncomment the following to have Vim jump to the last position when
  " reopening a file
   if has("autocmd")
	  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	endif
]],
  false
)

-- Save location of cursor from last session. New sessions start there:
vim.cmd([[
autocmd VimLeave * execute s:isActiveSession() && s:saveSession()
]])

-- Selected Text can be yanked to the clippboard with y+:
vim.cmd([[
set clipboard=unnamedplus
]])
