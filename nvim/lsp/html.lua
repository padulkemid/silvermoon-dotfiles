return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  settings = {
    html = {
      completion = {
        attributeDefaultValue = 'singlequotes',
      },
    },
  },
}
