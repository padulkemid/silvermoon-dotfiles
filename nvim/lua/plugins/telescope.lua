return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope' },
    event = { 'VimEnter' },
    version = '*',
    init = function()
      require('utils.helpers').lazy_load 'telescope.nvim'
    end,
    dependencies = { 'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      }
    },
    config = function()
      local set = vim.keymap.set
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local icons = require('mini.icons')

      icons.mock_nvim_web_devicons()

      telescope.setup {
        pickers = {
          colorscheme = {
            enable_preview = true
          }
        },
        defaults = {
          preview = {
            treesitter = false,
          },
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
      set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
      -- set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      set('n', '<leader>f', builtin.find_files, { desc = 'Search [F]iles' })
      set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
      set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
      set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
    end
  },
}
