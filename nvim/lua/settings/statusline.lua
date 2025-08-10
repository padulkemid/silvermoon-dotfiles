local branch = vim.fn.system 'git branch --show-current 2>/dev/null | tr -d "\n"'
local branch_status = function()
  if branch ~= '' then
    return '[' .. branch .. ']'
  end

  return ''
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  callback = function()
    vim.opt_local.statusline = table.concat {
      '%#StatusLine#',
      branch_status(),
      '%y',
      '%=',
      '[%f]',
      '%=',
      '%h%w%m%r[%l:%c][%P]',
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
