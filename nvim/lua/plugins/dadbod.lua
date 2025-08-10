return {
  'kristijanhusak/vim-dadbod-ui',
  cmd = { 'DBUI' },
  dependencies = {
    {
      'tpope/vim-dadbod',
      lazy = true,
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
    },
  },
  init = function()
    vim.g.ftplugin_sql_omni_key = '<C-x>'
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_help = 0
  end,
}
