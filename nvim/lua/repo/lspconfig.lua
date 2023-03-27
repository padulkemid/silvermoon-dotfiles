return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'folke/neodev.nvim',
    { 'j-hui/fidget.nvim',       opts = {} },
  },
}
