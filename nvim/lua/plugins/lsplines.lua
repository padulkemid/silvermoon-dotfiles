return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  init = function()
    require('utils.helpers').lazy_load 'lsp_lines.nvim'
  end,
  config = function()
    require('lsp_lines').setup()
    vim.diagnostic.config { virtual_text = false, virtual_lines = true }

    -- uncomment for functionality
    --[[ vim.keymap.set("", "<leader>l", function()
      local config = vim.diagnostic.config() or {}
      if config.virtual_text then
        vim.diagnostic.config { virtual_text = false, virtual_lines = true }
      else
        vim.diagnostic.config { virtual_text = true, virtual_lines = false }
      end
    end, { desc = "Toggle lsp_lines" }) ]]
  end
}
