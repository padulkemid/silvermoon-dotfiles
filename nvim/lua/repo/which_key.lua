return {
  'folke/which-key.nvim',
  keys = { '<leader>' },
  init = function()
    require('utils.helpers').lazy_load 'which-key.nvim'
  end,
  opts = {},
}
