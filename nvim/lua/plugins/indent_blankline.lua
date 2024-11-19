return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  init = function()
    require('utils.helpers').lazy_load 'indent-blankline.nvim'
  end,
  opts = {
    indent = {
      char = '╎',
    },
  },
}
