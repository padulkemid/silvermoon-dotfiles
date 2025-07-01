return {
  'echasnovski/mini.nvim',
  cmd = { 'Pick' },
  config = function()
    local files = require 'mini.files'
    local icons = require 'mini.icons'
    local surround = require 'mini.surround'
    local git = require 'mini.git'
    local ai = require 'mini.ai'
    local pick = require 'mini.pick'
    local extra = require 'mini.extra'

    -- setup mini things
    files.setup {
      mappings = {
        go_in_plus = '<CR>',
        go_out_plus = '<BS>',
        reset = 'r',
      },
    }

    icons.setup {
      style = 'ascii',
    }

    pick.setup {
      options = {
        content_from_bottom = true,
        use_cache = true,
      },
      mappings = {
        move_down = '<C-j>',
        move_up = '<C-k>',
        choose_in_split = '<C-x>',
        mark = '',
      },
    }

    surround.setup()
    git.setup()
    ai.setup()
    extra.setup()

    -- setup keymaps
    local set = vim.keymap.set

    -- files
    set('n', '<Bslash>', files.open, { desc = 'Open Files' })

    -- git
    set('v', 'gl', git.show_range_history, { desc = '[G]it [L]og' })

    -- pick
    set('n', '<leader>fr', ':Pick resume<CR>', { desc = '[F]ind Files [R]esume' })
    set('n', '<leader>sh', ':Pick help<CR>', { desc = '[S]earch [H]elp' })
    set('n', '<leader>sg', ':Pick grep_live<CR>', { desc = '[S]earch [G]rep' })
    set('n', '<leader>sb', ':Pick buffers<CR>', { desc = '[S]earch [B]uffers' })
    set('n', '<leader>sw', ':Pick grep pattern="<cword>"<CR>', { desc = '[S]earch [L]ive' })
    set('n', '<leader>sd', function()
      extra.pickers.diagnostic { scope = 'current' }
    end, { desc = '[S]earch [D]iagnostics' })
    set('n', 'gr', function()
      extra.pickers.lsp { scope = 'references' }
    end, { desc = '[G]oto [R]eferences' })
    set('n', '<leader>ds', function()
      extra.pickers.lsp { scope = 'document_symbol' }
    end, { desc = '[D]ocument [S]ymbols' })
    set('n', '<leader>ws', function()
      extra.pickers.lsp { scope = 'workspace_symbol' }
    end, { desc = '[W]orkspace [S]ymbols' })
  end,
}
