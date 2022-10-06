-- Set colorscheme (order is important here).
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.cmd [[colorscheme moonfly]]

--Set statusbar.
vim.g.lightline = {
  colorscheme = 'moonfly',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

