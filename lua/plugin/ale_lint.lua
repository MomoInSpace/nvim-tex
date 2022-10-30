-- Settings for ALE linter

vim.cmd(
[[
let g:ale_fixers = {
\	'*':  ['remove_trailing_lines', 'trim_whitespace'],
\	'javascript': ['eslint'],
\	'latex': ['textlint'],
\ 	'python':['autoflake',
\             'isort',
\             'reorder-python-imports',
\ 			  'autoimport'],
\}
" Ale
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['pylint']}
]])

