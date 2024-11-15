return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = function()
    local on_attach = function(client, bufnr)
      -- disable syntax highlight
      client.server_capabilities.semanticTokensProvider = nil

      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Flutter [C]ode [A]ction' })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Flutter [G]oto [D]efinition' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Flutter Hover Documentation' })
    end

    require('flutter-tools').setup {
      widget_guides = {
        enabled = true,
      },
      lsp = {
        on_attach = on_attach,
      },
    }
  end,
}
