local augroup = vim.api.nvim_create_augroup('PadulConfig', { clear = true })
local set = vim.keymap.set

-- Highlight on yanking shit
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Return to last edit position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Disable line in terminal mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Show diagnostics
vim.api.nvim_create_autocmd('BufReadPre', {
  group = augroup,
  callback = function()
    vim.diagnostic.config {
      virtual_text = false,
      virtual_lines = true,
      severity_sort = true,
    }

    set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
  end,
})
