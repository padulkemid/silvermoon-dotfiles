vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
}

local blink = require 'blink.cmp'
local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = {
  lua_ls = {},
  vtsls = {},
  clangd = {},
  cssls = {},
  html = {},
  jsonls = {},
  dartls= {},
  cucumber_language_server = {},
  emmet_languange_server = {},
}

local lsp_list = {}

for name, config in pairs(servers) do
  config = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities({}, false))
  table.insert(lsp_list, name)
  vim.lsp.config(name, config)
end

vim.lsp.enable(lsp_list)
