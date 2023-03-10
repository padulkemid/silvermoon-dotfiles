vim.g.mapleader = ','

vim.keymap.set('n', '<leader><leader>', vim.cmd.noh)
vim.keymap.set('n', '<leader>tn', vim.cmd.tabn)
vim.keymap.set('n', '<leader>tp', vim.cmd.tabp)
vim.keymap.set('n', '<leader>te', vim.cmd.tabe)
vim.keymap.set('n', '<leader>;', vim.cmd.bw)

vim.keymap.set('n', '<leader>gb', function()
	vim.cmd('Git blame')
end)
