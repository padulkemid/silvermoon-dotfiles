return {
  'lewis6991/gitsigns.nvim',
  ft = 'gitcommit',
  init = function()
    -- this will load gitsigns only on git files
    vim.api.nvim_create_autocmd({ 'BufRead' }, {
      group = vim.api.nvim_create_augroup('GitSignsLazyLoad', { clear = true }),
      callback = function()
        vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")

        if vim.v.shell_error == 0 then
          vim.api.nvim_del_augroup_by_name 'GitSignsLazyLoad'

          vim.schedule(
            function()
              require('lazy').load { plugins = { 'gitsigns.nvim' } }
            end
          )
        end
      end
    })
  end,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signcolumn = false,
    numhl = true,
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local set = vim.keymap.set

      -- setup hunk keymaps
      set('n', ']g', function()
        if vim.wo.diff then
          vim.cmd.normal { ']g', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { buffer = bufnr, desc = 'Next [G]it Hunk' })

      set('n', '[g', function()
        if vim.wo.diff then
          vim.cmd.normal { '[g', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { buffer = bufnr, desc = 'Previous [G]it Hunk' })

      -- setup normal keymaps
      set('n', '<leader>gba', gitsigns.blame, { buffer = bufnr, desc = '[G]it [B]lame [A]ll' })
      set('n', '<leader>gbl', gitsigns.blame_line, { buffer = bufnr, desc = '[G]it [B]lame [L]ine' })
    end
  },
}
