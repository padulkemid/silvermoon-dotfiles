return {
  cmd = { 'vtsls', '--stdio' },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server',
            languages = { 'vue' },
            configNamespace = 'typescript',
          },
        },
      },
    },
  },
  filetypes = {
    'typescript',
    'typescriptreact',
    'javascript',
    'javascriptreact',
    'vue',
  },
}
