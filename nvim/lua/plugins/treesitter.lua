return {
  'nvim-treesitter/nvim-treesitter',
  init = function()
    require('utils.helpers').lazy_load 'nvim-treesitter'
  end,
  cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  build = ':TSUpdate',
  config = function()
    -- call the install update
    pcall(require('nvim-treesitter.install').update { with_sync = true })

    -- setup ts
    local tsconfig = require 'nvim-treesitter.configs'

    --- @diagnostic disable-next-line: missing-fields
    tsconfig.setup {
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
    }

    -- setup keymaps
    local set = vim.keymap.set

    set('n', '[d', vim.diagnostic.get_prev, { desc = 'Go to previous diagnostic message' })
    set('n', ']d', vim.diagnostic.get_next, { desc = 'Go to next diagnostic message' })
    set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
  end,
}
