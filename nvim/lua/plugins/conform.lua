return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
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
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd', 'biome' },
        typescriptreact = { 'prettierd', 'biome' },
        css = { 'prettierd' },
        vue = { 'prettierd' },
        -- go = { 'gofumpt', 'golines', 'goimports' },
        json = { 'jq' },
        dart = { 'dart_format' },
        -- kotlin = { 'ktlint' },
        cucumber = { 'reformat-gherkin' },
        -- java = { 'google-java-format' },
        -- bash = { 'shfmt' },
        -- zsh = { 'shfmt' },
        -- make = { 'shfmt' },
        -- sh = { 'shfmt' },
        c = { 'clang-format' },
      },
      formatters = {
        biome = {
          cwd = require('conform.util').root_file { 'biome.json' },
          require_cwd = true,
        },
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
    }
  end,
}
