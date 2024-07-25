return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    require('utils.helpers').lazy_load 'vim-dadbod-ui'

    -- configs
    vim.g.ftplugin_sql_omni_key = '<C-x>'
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
