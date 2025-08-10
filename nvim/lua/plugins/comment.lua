return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPost' },
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    local ts_ctx = require 'ts_context_commentstring'
    local comment = require 'Comment'

    ts_ctx.setup()
    comment.setup()
  end,
}
