return {
  'rest-nvim/rest.nvim',
  ft = 'http',
  cmd = 'Rest',
  init = function()
    require('utils.helpers').lazy_load 'rest.nvim'
  end,
}
