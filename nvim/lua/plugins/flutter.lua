return {
  'nvim-flutter/flutter-tools.nvim',
  ft = 'dart',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'stevearc/dressing.nvim',
  },
  config = function()
    local set = vim.keymap.set

    -- TODO(v3: refactor this, this is deprecated)
    local on_attach = function(_, bufnr)
      set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Flutter [C]ode [A]ction' })
      set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Flutter [G]oto [D]efinition' })
      set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Flutter Hover Documentation' })
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
