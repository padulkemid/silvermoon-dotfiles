return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  cmd = 'Neotree',
  init = function()
    require('utils.helpers').lazy_load 'neo-tree.nvim'
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {}

    vim.keymap.set('n', '<Bslash>', ':Neotree<CR>')
  end,
}
