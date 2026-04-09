vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
}

local blink = require 'blink.cmp'
local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = blink.get_lsp_capabilities(default_capabilities, false)

local servers = {
  'lua_ls',
  'vtsls',
  'clangd',
  'cssls',
  'html',
  'jsonls',
  'dartls',
  'cucumber_language_server',
  'emmet_languange_server',
}

vim.lsp.config('*', {
  capabilities = capabilities,
})

vim.lsp.enable(servers)
