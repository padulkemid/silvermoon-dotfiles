return {
  'nvim-lualine/lualine.nvim',
  init = function()
    require('utils.helpers').lazy_load 'lualine.nvim'
  end,
  opts = {
    options = {
      icons_enabled = false,
      component_separators = '|',
      section_separators = '',
    },
  },
}
