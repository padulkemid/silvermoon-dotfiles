return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>ef',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  init = function()
    require('utils.helpers').lazy_load 'conform.nvim'
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      css = { 'prettierd' },
      vue = { 'prettierd' },
      go = { 'gofumpt', 'golines', 'goimports' },
      json = { 'jq' },
      dart = { 'dart_format' },
      kotlin = { 'ktlint' },
      cucumber = { 'reformat-gherkin' },
    },
    log_level = vim.log.levels.ERROR,
    notify_on_error = true,
  },
}
