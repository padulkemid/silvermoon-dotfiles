return {
  'lukas-reineke/indent-blankline.nvim',
  dependencies = {
    'tpope/vim-fugitive',
    'tpope/vim-sleuth',
    'tpope/vim-surround',
  },
  init = function()
    require('utils.helpers').lazy_load 'indent-blankline.nvim'
  end,
  opts = {
    char = '┊',
    show_trailing_blankline_indent = false,
  },
}
