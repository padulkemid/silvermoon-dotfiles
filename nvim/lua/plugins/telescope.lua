local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  },
  defaults = {
    mappings = {
      i = {
        ['<C-k>'] = 'move_selection_previous',
        ['<C-j>'] = 'move_selection_next',
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

pcall(telescope.load_extension, 'fzf')

-- Telescope keymaps
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
