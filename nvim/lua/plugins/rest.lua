return {
  'rest-nvim/rest.nvim',
  ft = 'http',
  init = function()
    require('utils.helpers').lazy_load 'rest.nvim'
  end,
  config = function()
    local set = vim.keymap.set
    local telescope = require('telescope')

    pcall(telescope.load_extension, 'rest')

    set('n', '<leader>re', telescope.extensions.rest.select_env, { desc = '[R]est [E]nv' })
  end
}
