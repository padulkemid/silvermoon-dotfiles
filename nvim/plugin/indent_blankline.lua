vim.pack.add {
  'https://github.com/lukas-reineke/indent-blankline.nvim',
}

local ibl = require 'ibl'
ibl.setup {
  indent = {
    char = '╎',
  },
}
