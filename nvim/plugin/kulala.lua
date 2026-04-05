vim.api.nvim_create_autocmd('FileType', {
  pattern = 'http',
  callback = function()
    vim.pack.add {
      'https://github.com/mistweaverco/kulala.nvim',
    }

    local kulala = require 'kulala'
    local set = vim.keymap.set

    kulala.setup {
      global_keymaps = false,
      global_keymaps_prefix = '<leader>R',
      kulala_keymaps_prefix = '',
    }

    set('n', '<leader>Rs', kulala.run, { desc = 'Send request' })
    set('n', '<leader>Rn', kulala.jump_next, { desc = 'Next request' })
    set('n', '<leader>Rp', kulala.jump_prev, { desc = 'Prev request' })
    set('n', '<leader>Rb', kulala.scratchpad, { desc = 'Scratchpad' })
    set('n', '<leader>Re', kulala.set_selected_env, { desc = 'Set env' })
  end,
})
