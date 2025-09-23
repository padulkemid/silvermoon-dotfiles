-- get shit from cmp, need it for the capabilites to extend autocomplete (blink
-- sounds better but nvim_cmp is still bread and butter)
local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- remember to install in Mason first, I turned off the autoinstaller because
-- fuck automatic installer
local servers = {
  -- no need configs
  jsonls = true,
  emmet_language_server = true,
  lua_ls = true,
  cssls = true,

  -- TODO: enable when I need it, no need it for now (I will learn
  -- C later to continue learning about linux kernal, its in my roadmap!)
  --[[ clangd = { 
    settings = {
      clangd = {
        arguments = {
          '--clang-tidy',
        },
      },
    },
  }, ]]

  -- every react or js stuff or ts, rescript, or what the fuck we are now
  html = {
    settings = {
      html = {
        completion = {
          attributeDefaultValue = 'singlequotes',
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
  },

  -- TODO: bread and butter settings but I don't do go anymore so its obsolete,
  -- still okay to have it though in the meantime...
  --[[ gopls = {
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
  }, ]]
}

local valid_lsp = {}
for name, config in pairs(servers) do
  if config == true then
    config = {}
  end

  config = vim.tbl_deep_extend('force', {}, {
    capabilities = capabilities,
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
