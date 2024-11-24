return {
  'rest-nvim/rest.nvim',
  ft = 'http',
  init = function()
    require('utils.helpers').lazy_load 'rest.nvim'
  end,
}
