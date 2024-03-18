return {
  'nvim-tree/nvim-web-devicons',
  init = function()
    require('utils.helpers').lazy_load 'nvim-web-devicons'
  end,
  opts = {},
}
