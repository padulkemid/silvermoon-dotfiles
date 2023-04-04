return {
  'nvim-treesitter/nvim-treesitter',
  init = function()
    require('utils.helpers').lazy_load 'nvim-treesitter'
  end,
  cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  build = ':TSUpdate',
  config = function()
    pcall(require('nvim-treesitter.install').update { with_sync = true })
  end,
}
