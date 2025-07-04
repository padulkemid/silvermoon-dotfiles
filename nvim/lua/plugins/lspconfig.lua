return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre' },
  dependencies = {
    {
      'Bilal2453/luvit-meta',
      lazy = true,
    },
    {
      'j-hui/fidget.nvim',
      opts = {},
    },
    {
      'folke/lazydev.nvim',
    },
  },
  config = function()
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- volar compatibility for ts_ls
    local mason_registry = require 'mason-registry'
    local mason_install_location = require 'mason-core.installer.InstallLocation'

    local vue_plugin_path = mason_registry.get_package 'vue-language-server'
    local vue_ls = mason_install_location.global():package(vue_plugin_path.name) .. '/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin'

    -- lsp servers
    local servers = {
      jsonls = true,
      -- jdtls = true,
      emmet_language_server = true,
      kotlin_language_server = {
        settings = {
          kotlin = {
            linting = {
              debounceTime = 50,
            },
            diagnostics = {
              debounceTime = 50,
            },
            inlayHints = {
              parameterHints = true,
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
      volar = true,
      lexical = true,
      ts_ls = {
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_ls,
              languages = { 'vue' },
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
      lua_ls = true,
      cssls = true,
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

    -- setup lspconfig
    local lspconfig = require 'lspconfig'
    for name, config in pairs(servers) do
      if config == true then
        config = {}
      end

      config = vim.tbl_deep_extend('force', {}, {
        capabilities = capabilities,
      }, config)

      lspconfig[name].setup(config)
    end

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
  end,
}
