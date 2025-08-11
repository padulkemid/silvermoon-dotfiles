return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPost' },
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
          --- @diagnostic disable-next-line: param-type-mismatch
          gitsigns.nav_hunk('next', { target = 'all' })
        end
      end, { buffer = bufnr, desc = 'Next [G]it Hunk' })

      set('n', '[g', function()
        if vim.wo.diff then
          vim.cmd.normal { '[g', bang = true }
        else
          --- @diagnostic disable-next-line: param-type-mismatch
          gitsigns.nav_hunk('prev', { target = 'all' })
        end
      end, { buffer = bufnr, desc = 'Previous [G]it Hunk' })

      -- setup normal keymaps
      set('n', '<leader>gba', gitsigns.blame, { buffer = bufnr, desc = '[G]it [B]lame [A]ll' })
      set('n', '<leader>gbl', gitsigns.blame_line, { buffer = bufnr, desc = '[G]it [B]lame [L]ine' })
    end,
  },
}
