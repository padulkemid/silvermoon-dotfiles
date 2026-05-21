--[[ local ns = vim.api.nvim_create_namespace 'dartls.closing_labels'

local function on_closing_labels(_, result)
  if not result or not result.uri or not result.labels then
    return
  end

  local bufnr = vim.uri_to_bufnr(result.uri)
  if bufnr < 0 or not vim.api.nvim_buf_is_loaded(bufnr) then
    return
  end

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  for _, label in ipairs(result.labels) do
    local pos = label.range['end']
    vim.api.nvim_buf_set_extmark(bufnr, ns, pos.line, pos.character, {
      virt_text = { { '// ' .. label.label, 'Comment' } },
      virt_text_pos = 'eol',
    })
  end
end ]]

--[[ vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(ev)
    vim.api.nvim_buf_clear_namespace(ev.buf, ns, 0, -1)
  end,
}) ]]

return {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml' },
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = true,
    suggestFromUnimportedLibraries = true,
    -- closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
      --[[ analysisExcludedFolders = {
        vim.fn.expand '$HOME/.pub-cache',
        vim.fn.expand '$HOME/flutter/bin/cache',
        vim.fn.getcwd() .. '/build/',
        vim.fn.getcwd() .. '/.dart_tool/',
      }, ]]
    },
  },
  --[[ handlers = {
    ['dart/textDocument/publishClosingLabels'] = on_closing_labels,
  }, ]]
}
