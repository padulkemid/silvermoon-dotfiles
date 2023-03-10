"  __________             .___            .__    /\
"  \______   \_____     __| _/____   ____ |  |   )/   ______
"   |     ___/\__  \   / __ |/  _ \_/ __ \|  |       /  ___/
"   |    |     / __ \_/ /_/ (  <_> )  ___/|  |__     \___ \
"   |____|    (____  /\____ |\____/ \___  >____/    /____  >
"                  \/      \/           \/               \/
"  .__       .__  __         .__
"  |__| ____ |__|/  |_ ___  _|__| _____
"  |  |/    \|  \   __\\  \/ /  |/     \
"  |  |   |  \  ||  |   \   /|  |  Y Y  \
"  |__|___|  /__||__| /\ \_/ |__|__|_|  /
"          \/         \/              \/
"============================================================
" God's Rebuke
set nocompatible
"============================================================

" Core Configs
" {{{
set relativenumber
set number
set showcmd
set showmode
set signcolumn=yes
set hidden
set updatetime=100
let mapleader=","
set swapfile
set title
set mouse=a
set encoding=utf-8
set formatoptions=tcrq
set shortmess+=c
set autoread
set autowrite
set nobackup
set nowritebackup
set splitright
set splitbelow
set fileformats=unix,dos,mac
set textwidth=80
set re=0
set spelllang=en
"}}}

" Spellcheck
"{{{
nnoremap <silent> <F8> :set spell!<CR>
"}}}

" Undo
"{{{
set history=1000
set undofile
set undolevels=100
set undoreload=1000
set undodir=~/.config/nvim/undodir
"}}}

" Color
"{{{
syntax on
set termguicolors
colorscheme iceberg
set colorcolumn=80
set background=light

nmap <silent> <leader><leader> :noh<CR>
"}}}

" Search
"{{{
set incsearch
set hlsearch
set ignorecase
set smartcase
set infercase
set endofline
set backspace=indent,eol,start
"}}}

" Statusline
"{{{
set laststatus=2

" Display format
function! s:statusline_expr()
let pur = "%#PmenuSel#"
let gra = "%#LineNr#"
let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
let ro  = "%{&readonly ? '[RO] ' : ''}"
let ft  = " %{len(&filetype) ? '['.&filetype.'] ' : ''}"
let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
let sep = ' %= '
let pos = ' %-12(%l : %c%V%) '
let pct = ' %P '


return pur.' silvermoon '.'%*'.' [%n] %f %<'.mod.gra.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()
"}}}

" Fold
"{{{
set foldmethod=manual

augroup filetype_vim
autocmd!
autocmd FileType vim setlocal foldmethod=marker
augroup END

nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
"}}}

" Indentation
"{{{
filetype plugin indent on
set autoindent
set expandtab
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set nowrap
set listchars=trail:»,tab:»-
set linebreak

"" Delete trailing whitespace
nnoremap <silent> <F9> :%s/\s\+$//e<CR>

nnoremap <silent> j gj
nnoremap <silent> k gk
"}}}

" Wildmenu & Clipboard
"{{{
set pastetoggle=<F2>
set path+=**
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/git/*
set wildmenu

" not to be confused with escape from insert mode
inoremap <C-c> <Esc>
xmap <C-c> "*y
xmap <C-v> "*p
"}}}

" Macros
"{{{

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

nnoremap J mzJ`z
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

map q: :q

nmap <leader>tp :tabp<CR>
nmap <leader>tn :tabn<CR>
nmap <leader>te :tabe<CR>
nmap <leader>tc :tabc<CR>

nmap <leader>gb :Git blame<CR>

" command dewa, hati-hati
nmap <leader>f :CtrlP .<CR>
nmap <leader>rg :Rg<space>

" for easy motion
" map <leader>e <Plug>(easymotion-prefix)
" map <silent> <leader>ew <Plug>(easymotion-bd-w)
" map <silent> <leader>ee <Plug>(easymotion-bd-e)

" for easy align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" for buffer destroy
nmap <leader>; :bw<CR>
"}}}

"============================================================

" Plugins
"{{{
call plug#begin('~/.local/share/nvim/plugged')

" Colorscheme
Plug 'cocopon/iceberg.vim'

" Vim Omnipotent Being
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Vim Another Omniscience Being
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'

" Godsense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Utilites
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
" Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
" Plug 'psliwka/vim-smoothie'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Web
Plug 'mattn/emmet-vim'
Plug 'andymass/vim-matchup'

" Javascript
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" Typescript
Plug 'HerringtonDarkholme/yats.vim'

" Dart
" Plug 'dart-lang/dart-vim-plugin'

" Go
" Plug 'fatih/vim-go'

" GraphQL
Plug 'jparise/vim-graphql'

" Markdown
Plug 'plasticboy/vim-markdown'

" Discord
" Plug 'vimsence/vimsence'

call plug#end()
"}}}

" Plugin Configurations
"{{{

" fzf
"{{{
set rtp+=/usr/local/opt/fzf
let g:fzf_layout= { 'down': '~60%' }

"}}}

" Goyo
"{{{
" function! s:goyo_enter()
  " if executable('tmux') && strlen($TMUX)
    " silent !tmux set status off
    " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  " endif
  " set noshowmode
  " set noshowcmd
  " set scrolloff=999
  " Limelight
  " " ...
" endfunction

" function! s:goyo_leave()
  " if executable('tmux') && strlen($TMUX)
    " silent !tmux set status on
    " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  " endif
  " set showmode
  " set showcmd
  " set scrolloff=5
  " Limelight!
  " " ...
" endfunction

" autocmd! User GoyoEnter nested call <SID>goyo_enter()
" autocmd! User GoyoLeave nested call <SID>goyo_leave()

"}}}

" vim-javascript
"{{{
let g:vim_jsx_pretty_colorful_config=1
"}}}

" vim-markdown
" {{{
let g:vim_markdown_folding_style_pythonic = 1
" }}}

" CtrlP
"{{{
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|coverage\|\.git/\|vendor\|_site\|_production*'
let g:ctrlp_max_files = 0
"}}}

" Emmet
"{{{
let g:user_emmet_leader_key='<c-e>'
let g:user_emmet_mode='iv'
"}}}

" NERDCommenter
"{{{
let g:NERDSpaceDelims=1
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
"}}}

" CoC Nvim
"{{{
set pumheight=10
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Applying codeAction to the selected region.
xmap <leader>cac  <Plug>(coc-codeaction-selected)
nmap <leader>cac  <Plug>(coc-codeaction-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>caf  <Plug>(coc-fix-current)

autocmd CursorHold * silent call CocActionAsync('highlight')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

autocmd FileType go nmap gtj :CocCommand go.tags.add json<CR>

"}}}

" vimsence
"{{{
" let g:vimsence_small_text = 'NeoVim'
" let g:vimsence_small_image = 'neovim'
"}}}

"}}}


"============================================================

" Custom Commands
"{{{

" Tags
" command MakeTags !ctags -R .

" Typo
command W :w
command Q :q
command Wq :wq

" vue
" autocmd BufRead,BufNewFile *.vue set filetype=vue

" vim-pencil + md
" autocmd BufRead,BufNewFile *.md set filetype=markdown

"}}}
