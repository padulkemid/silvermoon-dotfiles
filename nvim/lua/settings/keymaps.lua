local set = vim.keymap.set

-- Map leader to do nothing
set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

-- Remove highlight after doing something
set('n', '<leader><leader>', ':noh<CR>', { silent = true })

-- Move tabs back and forth
set('n', '<leader>te', ':tabe<CR>')
set('n', '<leader>tn', ':tabn<CR>')
set('n', '<leader>tp', ':tabp<CR>')

-- Destroy buffer
set('n', '<leader>;', ':bw<CR>')

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for copying and paste-ing from outside buffer (MacOS only)
set('x', '<C-c>', '"*y')
set('x', '<C-v>', '"*p')

-- Map escape to be easier to work with
set('i', '<C-c>', '<C-[>', { silent = true })

-- Move windows back and forth, vim motions
set('', '<C-j>', '<C-W>j')
set('', '<C-k>', '<C-W>k')
set('', '<C-h>', '<C-W>h')
set('', '<C-l>', '<C-W>l')

-- Search next word and centers the buffer
set('n', 'n', 'nzzzv', { remap = true })
set('n', 'N', 'Nzzzv', { remap = true })

-- Scroll buffer and centers it
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

-- Motion shortcut remap
set('n', 'H', '^', { remap = true })
set('n', 'L', '$', { remap = true })
set('v', 'H', '^', { remap = true })
set('v', 'L', 'g_', { remap = true })

-- Alt-like movestyle to move block
-- set('n', 'J', 'mzJ`z', { remap = true })
set('v', 'J', ":m '>+1<CR>gv=gv", { remap = true })
set('v', 'K', ":m '<-2<CR>gv=gv", { remap = true })

-- Remap q: so it doesn't confuse :q
set('', 'q:', ':q')
set('', ':Q', ':q')
set('', ':W', ':w')

-- Terminal exit
set('t', '<C-\\><C-\\>', '<C-\\><C-n>', { remap = true })

-- Copy filepath
set('n', '<leader>cfp', ':let @+=expand("%:p")<CR>', { desc = '[C]opy [F]ull [P]ath' })

-- Open Picker
set('n', '<leader>ff', ':Pick files<CR>', { desc = '[F]ind [F]iles' })
