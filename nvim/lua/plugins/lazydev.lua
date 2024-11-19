return {
  "folke/lazydev.nvim",
  ft = "lua",
  init = function()
    require('utils.helpers').lazy_load 'lazydev.nvim'
  end,
  opts = {
    library = {
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}
