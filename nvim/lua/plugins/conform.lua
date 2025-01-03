return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = 'ConformInfo',
  keys = {
    {
      '<leader>ef',
      function()
        require('conform').format { async = true, lsp_fallback = true }
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
      vue = { 'prettierd' },
      go = { 'gofumpt', 'golines', 'goimports' },
      json = { 'jq' },
      dart = { 'dartls' },
      kotlin = { 'ktlint' }
    },
    log_level = vim.log.levels.ERROR,
    notify_on_error = true,
  },
}
