return {
  'nvim-neorg/neorg',
  version = '*',
  ft = 'norg',
  cmd = 'Neorg',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    require('utils.helpers').lazy_load 'neorg'
  end,
  config = function()
    require('neorg').setup {
      load = {
        ['core.export'] = {},
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.concealer'] = {}, -- Adds pretty icons to your documents
        ['core.dirman'] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = '~/Work/notes',
            },
          },
        },
      },
    }
  end,
}
