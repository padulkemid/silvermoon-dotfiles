return {
  'echasnovski/mini.nvim',
  init = function()
    require('utils.helpers').lazy_load 'mini.nvim'
  end,
  config = function()
    local files = require 'mini.files'
    local icons = require 'mini.icons'
    local surround = require 'mini.surround'
    local git = require 'mini.git'

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

    surround.setup()
    git.setup()

    -- setup keymaps
    local set = vim.keymap.set

    set('n', '<Bslash>', files.open, { desc = 'Open Files' })
    set('v', 'gl', git.show_range_history, { desc = '[G]it [L]og' })
  end
}
