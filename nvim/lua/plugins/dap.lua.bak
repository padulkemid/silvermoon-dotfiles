return {
  {
    'mfussenegger/nvim-dap',
    ft = { 'go', 'dart', 'kotlin' },
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      local set = vim.keymap.set

      require('dapui').setup()
      require('dap-go').setup()

      -- kotlin
      dap.adapters.kotlin = {
        type = 'executable',
        command = 'kotlin-debug-adapter',
        options = { auto_continue_if_many_stopped = false },
      }

      dap.configurations.kotlin = {
        {
          type = 'kotlin',
          request = 'launch',
          name = 'This file',
          -- may differ, when in doubt, whatever your project structure may be,
          -- it has to correspond to the class file located at `build/classes/`
          -- and of course you have to build before you debug
          mainClass = function()
            local root = vim.fs.find('src', { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ''
            local fname = vim.api.nvim_buf_get_name(0)
            -- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
            return fname:gsub(root, ''):gsub('main/kotlin/', ''):gsub('.kt', 'Kt'):gsub('/', '.'):sub(2, -1)
          end,
          projectRoot = '${workspaceFolder}',
          jsonLogFile = '',
          enableJsonLogging = false,
        },
        {
          -- Use this for unit tests
          -- First, run
          -- ./gradlew --info cleanTest test --debug-jvm
          -- then attach the debugger to it
          type = 'kotlin',
          request = 'attach',
          name = 'Attach to debugging session',
          port = 5005,
          args = {},
          projectRoot = vim.fn.getcwd,
          hostName = 'localhost',
          timeout = 2000,
        },
      }

      -- Eval var under cursor
      set('n', '<leader>uk', function()
        --- @diagnostic disable-next-line: missing-fields
        require('dapui').eval(nil, { enter = true })
      end)

      set('n', '<leader>dtb', dap.toggle_breakpoint)
      set('n', '<leader>dtc', dap.run_to_cursor)
      set('n', '<leader>dc', dap.continue)
      set('n', '<leader>dti', dap.step_into)
      set('n', '<leader>dtv', dap.step_over)
      set('n', '<leader>dto', dap.step_out)
      set('n', '<leader>dtk', dap.step_back)
      set('n', '<leader>dr', dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
