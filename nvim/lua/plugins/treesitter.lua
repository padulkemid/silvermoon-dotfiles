return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'VeryLazy' },
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
  end,
}
