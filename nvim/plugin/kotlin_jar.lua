-- Open jar:// / jrt:// URIs via kotlin_lsp `decompile`.
-- Enabled only after a Kotlin buffer is opened (FileType kotlin).
-- Based on AlexandrosAlexiou/kotlin.nvim decompiler + autocommands.

local TIMEOUT_MS = 5000
local enabled = false

local function decompile_uri(uri)
  local clients = vim.lsp.get_clients { name = 'kotlin_lsp' }
  local client = clients[1]

  if not client then
    vim.notify('kotlin_lsp not running — open a .kt file first', vim.log.levels.WARN)
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local bo = vim.bo[buf]

  bo.modifiable = true
  bo.swapfile = false
  bo.buftype = 'nofile'
  bo.filetype = 'java'

  local done, result

  client:request('workspace/executeCommand', {
    command = 'decompile',
    arguments = { uri },
  }, function(err, res)
    done = true
    if err then
      vim.notify('decompile failed: ' .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end
    result = res
  end)

  -- Block so gd can place the cursor after content exists.
  vim.wait(TIMEOUT_MS, function()
    return done
  end)

  if type(result) ~= 'table' or type(result.code) ~= 'string' then
    return
  end

  local code = result.code:gsub('\r\n', '\n')
  local lines = vim.split(code, '\n', { plain = true })

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  if result.language then
    bo.filetype = result.language:lower()
  end

  bo.modifiable = false
end

local function enable_jar_handlers()
  if enabled then
    return
  end
  enabled = true

  local augroup = vim.api.nvim_create_augroup('KotlinJarDecompile', { clear = true })

  for _, protocol in ipairs { 'jar', 'jrt' } do
    vim.api.nvim_create_autocmd('BufReadCmd', {
      pattern = protocol .. '://*',
      group = augroup,
      desc = 'Decompile ' .. protocol .. ':// via kotlin-lsp (kotlin only)',
      callback = function(args)
        decompile_uri(args.match)
      end,
    })
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'kotlin',
  desc = 'Enable jar/jrt decompile handlers for Kotlin',
  callback = enable_jar_handlers,
})
