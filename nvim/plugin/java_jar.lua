-- java twin of kotlin_jar.lua — lets `gd` open decompiled jdt:// / .class via vanilla jdtls.
-- needs classFileContentsSupport in nvim/lsp/jdtls.lua. based on nvim-jdtls open_classfile.

local TIMEOUT_MS = 5000
local enabled = false

local function open_classfile(buf, fname)
  local client = vim.lsp.get_clients { name = 'jdtls', bufnr = buf }[1]
    or vim.lsp.get_clients { name = 'jdtls' }[1]

  if not client then
    vim.notify('jdtls not running — open a .java file first', vim.log.levels.WARN)
    return
  end

  local bo = vim.bo[buf]
  bo.modifiable = true
  bo.swapfile = false
  bo.buftype = 'nofile'
  bo.filetype = 'java'

  local done, result

  local handler = function(err, res)
    done = true
    if err then
      vim.notify('jdtls classfile failed: ' .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end
    result = res
  end

  if vim.startswith(fname, 'jdt://') then
    client:request('java/classFileContents', { uri = fname }, handler, buf)
  else
    client:request('workspace/executeCommand', {
      command = 'java.decompile',
      arguments = { vim.uri_from_fname(fname) },
    }, handler, buf)
  end

  -- block so gd can place the cursor after content exists.
  vim.wait(TIMEOUT_MS, function()
    return done
  end)

  local code = type(result) == 'string' and result
    or (type(result) == 'table' and (result.code or result.content))

  if type(code) ~= 'string' then
    return
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split((code:gsub('\r\n', '\n')), '\n', { plain = true }))
  bo.modifiable = false
end

local function enable_jar_handlers()
  if enabled then
    return
  end

  enabled = true

  local augroup = vim.api.nvim_create_augroup('JavaClassFile', { clear = true })

  for _, pattern in ipairs { 'jdt://*', '*.class' } do
    vim.api.nvim_create_autocmd('BufReadCmd', {
      pattern = pattern,
      group = augroup,
      desc = 'open decompiled ' .. pattern .. ' via jdtls',
      callback = function(args)
        open_classfile(args.buf, args.match)
      end,
    })
  end
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  desc = 'enable jdt:// / .class decompile handlers for Java',
  callback = enable_jar_handlers,
})
