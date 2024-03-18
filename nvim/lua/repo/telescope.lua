return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    version = '*',
    init = function()
      require('utils.helpers').lazy_load 'telescope.nvim'
    end,
    dependencies = { 'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      }
    },
  },
}
