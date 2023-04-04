return {
  'lukas-reineke/indent-blankline.nvim',
  init = function()
    require('utils.helpers').lazy_load 'indent-blankline.nvim'
  end,
  opts = {
    char = '┊',
    show_trailing_blankline_indent = false,
  },
}
