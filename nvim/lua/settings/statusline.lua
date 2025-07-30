local branch = vim.fn.system 'git branch --show-current 2>/dev/null | tr -d "\n"'

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  callback = function()
    vim.opt_local.statusline = table.concat {
      '%#StatusLine#',
      '[%f] %h%w%m%r',
      '[' .. branch .. ']',
      '%=',
      '[%l:%c] [%P] %y',
    }
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  callback = function()
    vim.opt_local.statusline = table.concat {
      '%#StatusLineNC#',
      '[%f]',
    }
  end,
})
