return {
  'andythigpen/nvim-coverage',
  cmd = 'Coverage',
  init = function()
    require('utils.helpers').lazy_load 'nvim-coverage'
  end,
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require('coverage').setup {
      signs = {
        covered = { hl = 'CoverageCovered', text = '' },
        uncovered = { hl = 'GitGutterDelete', text = '♠' },
        partial = { hl = 'GitGutterChange', text = '❖' }
      },
    }
  end,
}
