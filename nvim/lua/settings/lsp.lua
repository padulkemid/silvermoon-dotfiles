-- vue_ls hell for vtsls (fuck ts_ls!) mason location
local vue_language_server_path = vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

-- TODO(v3: move this to ramp up nightly)
-- lsp servers
local servers = {
  jsonls = true,
  emmet_language_server = true,
  bashls = true,
  lua_ls = true,
  tailwindcss = true,
  cssls = true,
  clangd = {
    settings = {
      clangd = {
        arguments = {
          '--clang-tidy',
        },
      },
    },
  },
  cucumber_language_server = {
    settings = {
      cucumber = {
        features = { '**/*.feature' },
        glue = { '**/*_steps.ts', '**/*_step.ts' },
      },
    },
  },
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
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
  },
  gopls = {
    settings = {
      gopls = {
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
          useany = true,
        },
        experimentalPostfixCompletions = true,
        gofumpt = true,
        usePlaceholders = true,
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
  },
  html = {
    settings = {
      html = {
        completion = {
          attributeDefaultValue = 'singlequotes',
        },
      },
    },
  },
}

-- TODO(v3: deprecated)
-- setup lspconfig
-- move to a single file later
local valid_lsp = {}
for name, config in pairs(servers) do
  if config == true then
    config = {}
  end

  config = vim.tbl_deep_extend('force', {}, {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  }, config)

  table.insert(valid_lsp, name)
  vim.lsp.config(name, config)
end

vim.lsp.enable(valid_lsp)

-- setup lsp attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client_id = vim.lsp.get_client_by_id(args.data.client_id)
    local client = assert(client_id, 'you need to have a valid client')

    local settings = servers[client.name]
    if type(settings) ~= 'table' then
      settings = {}
    end

    local set = vim.keymap.set
    set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0, desc = '[C]ode [A]ction' })
    set('n', 'gd', vim.lsp.buf.definition, { buffer = 0, desc = '[G]oto [D]efinition' })
    set('n', 'gI', vim.lsp.buf.implementation, { buffer = 0, desc = '[G]oto [I]mplementation' })
    set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = 0, desc = 'Type [D]efinition' })
    set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0, desc = '[G]oto [D]eclaration' })
    set('n', 'K', vim.lsp.buf.hover, { buffer = 0, desc = 'Hover Documentation' })
    set('n', '<leader>K', vim.lsp.buf.signature_help, { buffer = 0, desc = 'Signature Documentation' })

    if settings.server_capabilities then
      for key, value in pairs(settings.server_capabilities) do
        if value == vim.NIL then
          ---@diagnostic disable-next-line: cast-local-type
          value = nil
        end

        client.server_capabilities[key] = value
      end
    end
  end,
})
