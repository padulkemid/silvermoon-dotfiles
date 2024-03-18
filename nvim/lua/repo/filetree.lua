-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
vim.keymap.set('n', '<Bslash>', ':Neotree<CR>')

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
  end,
}
