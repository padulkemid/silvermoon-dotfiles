local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('settings.options')
require('settings.keymaps')
require('utils.lazy')
require('utils.visuals')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.lsp')
