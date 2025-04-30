return {
  "rest-nvim/rest.nvim",
  ft = 'http',
  init = function()
    require('utils.helpers').lazy_load 'rest.nvim'
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  }
}
