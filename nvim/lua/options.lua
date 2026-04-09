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
vim.o.formatoptions = 'jcroqlnt'

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
vim.o.synmaxcol = 300
vim.o.virtualedit = 'block'

-- File handling
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undolevels = 10000
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
vim.o.backspace = 'indent,eol,start'
vim.o.jumpoptions = 'view'

-- Performance
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000

-- C style for H
vim.g.c_syntax_for_h = 1

-- Diagnostic
vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = true,
  severity_sort = true,
}

-- Filetypes
vim.filetype.add {
  extension = {
    ['env'] = 'dotenv',
    ['http'] = 'http',
  },
  filename = {
    ['.env'] = 'dotenv',
    ['env'] = 'dotenv',
  },
  pattern = {
    ['[jt]sconfig.*.json'] = 'jsonc',
    ['%.env%.[%w_.-]+'] = 'dotenv',
  },
}
