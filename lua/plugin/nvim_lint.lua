-- Settings for nvim-lint:
-- https://github.com/mfussenegger/nvim-lint

require('lint').linters_by_ft = {
  markdown = {'vale',},
  python = {'pylint',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
