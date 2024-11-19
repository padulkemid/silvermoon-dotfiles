return {
  {
    'mfussenegger/nvim-dap',
    ft = 'go',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    init = function()
      require('utils.helpers').lazy_load 'nvim-dap'
    end,
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      local set = vim.keymap.set

      require('dapui').setup()
      require('dap-go').setup()

      set('n', '<leader>tb', dap.toggle_breakpoint)
      -- set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      set('n', '<leader>uk', function()
        --- @diagnostic disable-next-line: missing-fields
        require('dapui').eval(nil, { enter = true })
      end)

      set('n', '<F1>', dap.continue)
      set('n', '<F2>', dap.step_into)
      set('n', '<F3>', dap.step_over)
      set('n', '<F4>', dap.step_out)
      set('n', '<F5>', dap.step_back)
      set('n', '<F6>', dap.restart)

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
