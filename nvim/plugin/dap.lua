vim.pack.add {
  'https://codeberg.org/mfussenegger/nvim-dap',
}

local dap = require 'dap'
local set = vim.keymap.set

dap.adapters.flutter_test = {
  type = 'executable',
  command = vim.fn.exepath 'flutter',
  args = { 'debug_adapter', '--test' },
}

dap.configurations.dart = {
  {
    name = 'Flutter test: current file',
    type = 'flutter_test',
    request = 'launch',
    program = '${file}',
    toolArgs = { '--no-test-assets' },
    cwd = function()
      return vim.fs.root(0, 'pubspec.yaml') or vim.fn.getcwd()
    end,
  },
}

dap.adapters.kotlin = function(callback)
  local client = vim.lsp.get_clients { name = 'kotlin_lsp', bufnr = 0 }[1]
    or vim.lsp.get_clients { name = 'kotlin_lsp' }[1]
  if not client then
    vim.notify('Open a Kotlin file and wait for kotlin_lsp', vim.log.levels.ERROR)
    return
  end

  client:request('workspace/executeCommand', {
    command = 'start_debug_server',
    arguments = { vim.uri_from_fname(client.root_dir or vim.fn.getcwd()) },
  }, function(err, port)
    if err then
      vim.schedule(function()
        vim.notify(vim.inspect(err), vim.log.levels.ERROR)
      end)
      return
    end
    vim.schedule(function()
      callback {
        type = 'server',
        host = '127.0.0.1',
        port = assert(tonumber(port), 'bad port from kotlin_lsp'),
        id = 'intellij_jvm',
      }
    end)
  end)
end

dap.configurations.kotlin = {
  {
    name = 'Attach to Kotlin/JVM (JDWP)',
    type = 'kotlin',
    request = 'attach',
    hostName = '127.0.0.1',
    port = function()
      return tonumber(vim.fn.input('JDWP port: ', '5005')) or 5005
    end,
  },
}

set('n', '<leader>xb', dap.toggle_breakpoint, { desc = 'Debug breakpoint' })
set('n', '<leader>xB', dap.clear_breakpoints, { desc = 'Debug clear breakpoints' })
set('n', '<leader>xc', dap.continue, { desc = 'Debug continue' })
set('n', '<leader>xn', dap.step_over, { desc = 'Debug next' })
set('n', '<leader>xi', dap.step_into, { desc = 'Debug into' })
set('n', '<leader>xo', dap.step_out, { desc = 'Debug out' })
set('n', '<leader>xq', dap.terminate, { desc = 'Debug terminate' })
set({ 'n', 'v' }, '<leader>xv', function()
  require('dap.ui.widgets').hover()
end, { desc = 'Debug value' })
set('n', '<leader>xr', dap.repl.open, { desc = 'Debug REPL' })
