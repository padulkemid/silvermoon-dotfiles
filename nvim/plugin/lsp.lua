vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
}

local blink = require 'blink.cmp'
local capabilities = vim.lsp.protocol.make_client_capabilities()
local set = vim.keymap.set

local servers = {
  lua_ls = {},
  vtsls = {},
  clangd = {},
  cssls = {},
  html = {},
  jsonls = {},
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

set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
set('n', 'gI', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
set('n', '<leader>K', vim.lsp.buf.signature_help, { desc = 'Signature Help' })
