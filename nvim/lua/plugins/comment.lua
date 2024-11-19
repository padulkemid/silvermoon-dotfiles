return {
  'numToStr/Comment.nvim',
  init = function()
    require('utils.helpers').lazy_load 'Comment.nvim'
  end,
  opts = {},
}
