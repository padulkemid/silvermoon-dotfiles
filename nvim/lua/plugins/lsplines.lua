return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = { 'BufReadPre' },
  config = function()
    require('lsp_lines').setup()
    vim.diagnostic.config { virtual_text = false, virtual_lines = true }
    vim.lsp.inlay_hint.enable(false)

    -- setup keymaps
    local set = vim.keymap.set

    set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    -- uncomment for functionality
    --[[ vim.keymap.set("", "<leader>l", function()
      local config = vim.diagnostic.config() or {}
      if config.virtual_text then
        vim.diagnostic.config { virtual_text = false, virtual_lines = true }
      else
        vim.diagnostic.config { virtual_text = true, virtual_lines = false }
      end
    end, { desc = "Toggle lsp_lines" }) ]]
  end,
}
