-- Leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Respect .editorconfig
vim.g.editorconfig = true


-- Remove mode in command bar (since it has been handled from lualine)
vim.o.showmode = false

-- Colors
vim.o.background = 'dark'
vim.o.termguicolors = true

-- Add textwidth maximum limit
vim.o.textwidth = 80

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching with highlights
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.infercase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'no'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Splits right and below when opening a new file
vim.o.splitright = true
vim.o.splitbelow = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Indentation
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.wrap = false

-- Theme
vim.api.nvim_set_hl(0, 'Normal', { bg = '#000000' })
vim.cmd.syntax 'off'
