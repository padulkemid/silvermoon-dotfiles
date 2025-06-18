return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false,
  priority = 1000,
  config = function()
    require('github-theme').setup {
      options = {
        styles = {
          keywords = 'bold',
          constants = 'bold',
        },
      },
      palettes = {
        github_dark_high_contrast = {
          fg = {
            default = '#ffffff',
          },
        },
      },
      groups = {
        github_dark_high_contrast = {
          Normal = { fg = 'white', bg = 'black' },
          NormalNC = { bg = 'black' },
          StatusLine = { fg = 'black', bg = 'white' },
          StatusLineNC = { fg = 'black', bg = 'darkgray' },
          WinSeparator = { fg = 'white', bg = 'black' },
        },
      },
    }

    vim.cmd 'colorscheme github_dark_high_contrast'
  end,
}
