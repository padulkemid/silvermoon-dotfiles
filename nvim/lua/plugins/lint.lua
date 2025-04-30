return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  init = function()
    require('utils.helpers').lazy_load 'nvim-lint'
  end,
  config = function()
    local set = vim.keymap.set
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
      go = { 'golangcilint' },
      kotlin = { 'ktlint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })

    set('n', '<leader>eg', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
