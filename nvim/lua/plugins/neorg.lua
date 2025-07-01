return {
  'nvim-neorg/neorg',
  version = '*',
  ft = 'norg',
  dependencies = { 'nvim-lua/plenary.nvim' },
  
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
