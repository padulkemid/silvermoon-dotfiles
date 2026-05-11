--[[ 
-- !FOR ANYBODY WHO READS THIS!
--
-- The reason why I used `vim.cmd.packadd` not `vim.pack.add {}` here is
-- because I developed this theme locally and currently in stable NVIM 0.12.0
-- the way to do it to reflect local changes is by using `vim.cmd.packadd`
-- 
-- for some reason, it won't supported yet until somewhere in 0.12.3
-- guide to do this via: https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack.html#install-and-load
-- PR in neovim: https://github.com/neovim/neovim/pull/37727
]]
vim.cmd.packadd 'nvim-256noir'

vim.cmd.colorscheme '256noir'
