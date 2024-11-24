return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    require('utils.helpers').lazy_load 'harpoon'
  end,
  config = function()
    local set = vim.keymap.set
    local harpoon = require 'harpoon'

    harpoon:setup()

    set('n', '<leader>ha', function() harpoon:list():add() end, { desc = '[H]arpoon [A]dd' })
    set('n', '<leader>hc', function() harpoon:list():clear() end, { desc = '[H]arpoon [C]lear' })
    set('n', '<leader><space>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon [F]iles' })
  end,
}
