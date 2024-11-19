return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  init = function()
    require('utils.helpers').lazy_load 'lsp_lines.nvim'
  end,
  config = function()
    require('lsp_lines').setup()
  end
}
