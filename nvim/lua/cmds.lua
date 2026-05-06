vim.api.nvim_create_user_command('Vt', function()
  vim.cmd 'vert ter'
end, { desc = 'vertical term' })

vim.api.nvim_create_user_command('Ht', function()
  vim.cmd 'hor ter'
end, { desc = 'vertical term' })
