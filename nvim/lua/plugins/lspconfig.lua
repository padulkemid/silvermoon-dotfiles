return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost' },
  dependencies = {
    {
      'Bilal2453/luvit-meta',
      lazy = true,
    },
    {
      'j-hui/fidget.nvim',
      opts = {},
    },
    --[[ {
      'mluders/comfy-line-numbers.nvim',
      opts = {},
    }, ]]
    {
      'folke/lazydev.nvim',
      -- 'stevearc/dressing.nvim',
      'williamboman/mason.nvim',
    },
  },
}
