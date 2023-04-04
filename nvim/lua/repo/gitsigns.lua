-- local helper functions
local function deleteAugroup()
  vim.api.nvim_del_augroup_by_name 'GitSignsLazyLoad'

  vim.schedule(
    function()
      require('lazy').load { plugins = { 'gitsigns.nvim' } }
    end
  )
end

local function expandAutoCmdCallback()
  vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")

  if vim.v.shell_error == 0 then
    deleteAugroup()
  end
end

local function loadGitsignsInGitFile()
  -- load gitsigns only when a git file is opened
  vim.api.nvim_create_autocmd({ 'BufRead' }, {
    group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
    callback = expandAutoCmdCallback
  })
end

-- mapping
vim.keymap.set('n', ']g', function()
  if vim.wo.diff then
    return ']g'
  end

  vim.schedule(function()
    require('gitsigns').next_hunk()
  end)

  return '<Ignore>'
end, { desc = 'Jump to next hunk', expr = true })

vim.keymap.set('n', '[g', function()
  if vim.wo.diff then
    return '[g'
  end

  vim.schedule(function()
    require('gitsigns').prev_hunk()
  end)

  return '<Ignore>'
end, { desc = 'Jump to previous hunk', expr = true })

return {
  'lewis6991/gitsigns.nvim',
  ft = 'gitcommit',
  init = loadGitsignsInGitFile,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
