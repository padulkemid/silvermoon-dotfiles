return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  dependencies = {
    'tpope/vim-fugitive',
    'tpope/vim-sleuth',
    'tpope/vim-surround',
  },
  init = function()
    require('utils.helpers').lazy_load 'indent-blankline.nvim'
  end,
  opts = {
    indent = {
      char = '╎',
    },
  },
}
