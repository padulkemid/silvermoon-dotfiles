return {
  'echasnovski/mini.nvim',
  init = function()
    require('utils.helpers').lazy_load 'mini.nvim'
  end,
  config = function()
    local files = require 'mini.files'
    local icons = require 'mini.icons'

    -- setup mini things
    files.setup {
      mappings = {
        go_in_plus = '<CR>',
        go_out_plus = '<BS>',
        reset = 'r',
      }
    }

    icons.setup {
      style = 'ascii'
    }

    -- setup keymaps
    local set = vim.keymap.set

    set('n', '<Bslash>', files.open, { desc = 'Open Files' })
  end
}
