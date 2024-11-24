return {
  'williamboman/mason.nvim',
  event = { 'VeryLazy'},
  init = function()
    require('utils.helpers').lazy_load 'mason.nvim'
  end,
  cmd = { 'Mason', 'MasonInstall' },
  config = true
}
