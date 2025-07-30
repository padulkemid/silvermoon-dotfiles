return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = { 'BufReadPre' },
  config = function()
    require('lsp_lines').setup()
    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
    vim.lsp.inlay_hint.enable(false)

    -- setup keymaps
    local set = vim.keymap.set

    set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
  end,
}
