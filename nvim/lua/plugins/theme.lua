-- testing my colorscheme
return {
  dir = '/Users/padulkemid/Work/personal-projects/nvim-plugins/nvim-256noir',
  name = 'nvim-256noir',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd 'colorscheme 256noir'
  end,
}
