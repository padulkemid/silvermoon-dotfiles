-- Basic
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- Indentation
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.textwidth = 80

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.infercase = true

-- Visual
vim.o.background = 'dark'
vim.o.winborder = 'single'
vim.o.termguicolors = true
vim.o.signcolumn = 'no'
vim.o.showmatch = true
vim.o.matchtime = 2
vim.o.cmdheight = 1
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.pumheight = 10
vim.o.synmaxcol = 500

-- File handling
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 0
vim.o.timeout = true
vim.o.autoread = true
vim.o.autowrite = false

-- Behavior
vim.o.mouse = 'a'
vim.o.laststatus = 2
vim.o.splitright = true
vim.o.splitbelow = true

-- Performance
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000
