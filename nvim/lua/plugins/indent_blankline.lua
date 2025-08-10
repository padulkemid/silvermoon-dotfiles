return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost' },
  main = 'ibl',
  opts = {
    indent = {
      char = '╎',
    },
  },
}
