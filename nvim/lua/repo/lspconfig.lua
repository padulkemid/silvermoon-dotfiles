return {
  'neovim/nvim-lspconfig',
  init = function()
    require('utils.helpers').lazy_load 'nvim-lspconfig'
  end,
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'folke/neodev.nvim',
    { 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },
  },
}
