return {
  'williamboman/mason.nvim',
  init = function()
    require('utils.helpers').lazy_load 'mason.nvim'
  end,
  cmd = { 'Mason', 'MasonInstall' },
  config = true
}
