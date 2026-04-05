vim.pack.add {
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
}

local ts_ctx = require 'ts_context_commentstring'
local comment = require 'Comment'

ts_ctx.setup {
  enable_autocmd = false,
}

comment.setup()
