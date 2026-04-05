vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
}

local conform = require 'conform'

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

conform.setup {
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
  default_format_opts = {
    lsp_format = 'fallback',
  },
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
}

-- keymap
local set = vim.keymap.set

set('n', '<leader>ef', function()
  conform.format({ async = true }, function(err, did_edit)
    if not err and did_edit then
      vim.notify('code formatted!', vim.log.levels.INFO, { title = 'Conform' })
    end
  end)
end, { desc = '[E]valuate and [F]ormat' })
