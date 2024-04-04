return {
  'Exafunction/codeium.vim',
  event = 'InsertEnter',
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'go', 'lua' },
  init = function()
    require('utils.helpers').lazy_load 'codeium.vim'
  end,
  config = function()
    vim.keymap.set('i', '<C-g>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-;>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-.>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true })
    vim.keymap.set('i', '<c-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true })
  end,
}
