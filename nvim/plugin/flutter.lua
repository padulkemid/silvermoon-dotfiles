vim.pack.add {
  'https://github.com/nvim-flutter/flutter-tools.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
}

local fl = require 'flutter-tools'

fl.setup {
  widget_guides = {
    enabled = true,
  },
}
