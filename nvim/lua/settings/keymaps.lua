-- Map leader to do nothing
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

-- Remove highlight after doing something
vim.keymap.set('n', '<leader><leader>', ':noh<CR>', { silent = true })

-- Move tabs back and forth
vim.keymap.set('n', '<leader>te', ':tabe<CR>')
vim.keymap.set('n', '<leader>tn', ':tabn<CR>')
vim.keymap.set('n', '<leader>tp', ':tabp<CR>')

-- Destroy buffer
vim.keymap.set('n', '<leader>;', ':bw<CR>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap for copying and paste-ing from outside buffer (MacOS only)
vim.keymap.set('x', '<C-c>', '"*y')
vim.keymap.set('x', '<C-v>', '"*p')

-- Map escape to be easier to work with
vim.keymap.set('i', '<C-c>', '<Esc>', { silent = true })

-- Move windows back and forth, vim motions
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Search next word and centers the buffer
vim.keymap.set('n', 'n', 'nzzzv', { remap = true })
vim.keymap.set('n', 'N', 'Nzzzv', { remap = true })

-- Scroll buffer and centers it
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Motion shortcut remap
vim.keymap.set('n', 'H', '^', { remap = true })
vim.keymap.set('n', 'L', '$', { remap = true })
vim.keymap.set('v', 'H', '^', { remap = true })
vim.keymap.set('v', 'L', 'g_', { remap = true })

-- Alt-like movestyle to move block
vim.keymap.set('n', 'J', 'mzJ`z', { remap = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { remap = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { remap = true })

-- Remap q: so it doesn't confuse :q
vim.keymap.set('', 'q:', ':q')

-- Blaming your shit because you're lame af
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
