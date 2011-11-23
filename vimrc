let g:mapleader=","
let g:maplocalleader="\\"

"" Interface
let &t_Co = empty($COLORTERM) ? 2 : 256
let g:lucius_style = 'blue'
colorscheme lucius

set nomodeline

set relativenumber
set lazyredraw
set ttyfast
set mouse=n

" Buffer
set switchbuf=usetab
nnoremap <c-n> :bnext<enter>
nnoremap <c-p> :bprevious<enter>

" Textarea
set scrolloff=6
set cursorcolumn cursorline
set showmatch
set list
set listchars=tab:▸\ ,trail:·
set linebreak
set textwidth=75
set formatoptions+=B1

syntax enable
set autoindent
set shiftround
set expandtab smarttab
for s:key in ['tabstop', 'shiftwidth', 'softtabstop']
  exec 'set ' . s:key . '=2'
endfor
unlet s:key
filetype plugin indent on

autocmd FileType * set foldmethod=manual
" Fix filetype
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType mako setl ts=2 sw=2 sts=2

" Set the damn file type
nnoremap <LocalLeader><LocalLeader> :setfiletype<space>
nnoremap <LocalLeader>mk :setfiletype<space>mako<cr>
nnoremap <LocalLeader>js :setfiletype<space>javascript<cr>

" Command line and status line.
cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

set history=300
set cmdheight=2
set showcmd
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set statusline=\ %f%m%r%h\ %w\ \ CWD:\ %{CurDir()}\ \ \ Line:\ %l/%L:%c
set shortmess+=aI

function! CurDir()
  let curdir = substitute(getcwd(),$HOME,"~","g")
  return curdir
endfunction

" Searching
set ignorecase smartcase
set incsearch
set hlsearch
nnoremap <backspace> :nohlsearch<enter>
noremap / /\v
noremap ? ?\v
nnoremap # #zz
nnoremap * *zz
noremap n nzz
noremap N Nzz

" Internal

" File handling

set autoread
set noswapfile
set nobackup
set nowritebackup
set hidden
set undofile
set undodir=~/.tmp
set undolevels=1000
autocmd BufReadPost * silent! normal g`"
autocmd! FocusLost * silent! wall
set autowrite

nnoremap <leader>w :update<CR>
nnoremap <leader>dd :bdelete<CR>
nnoremap <leader>da :1,300bdelete<CR>

" Utilities
nnoremap <leader>au :autocmd  <buffer><space><s-left><left>
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lc :lcd %:p:h<CR>
nnoremap <leader>g :Ack  --<s-left><left>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>== gg=G``

" Encoding
set fileformats=unix,dos,mac
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

" Diff options
set diffopt=filler,vertical
noremap <leader>du :diffupdate<enter>
nnoremap <leader>di :diffthis<enter>
nnoremap <leader>do :diffoff!<enter>

" Editing
set backspace=eol,start,indent
set noesckeys

inoremap $<space> <space><space><left>
inoremap $@ ()<left>
inoremap $2 []<left>
inoremap $# {}<left>
inoremap $3 <><left>
inoremap $4 {}<left><enter><esc>O
inoremap $$ $
inoremap $e ''<left>
inoremap $E ""<left>
inoremap $R <backspace><delete>

inoreabbrev rt return

" Let's give it a shot
nnoremap <space> a<space><esc>r
nnoremap <cr> a<space><esc>r<cr>

" Move around while in editing mode
" Leave <c-h> for backspace
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-e> <c-o>A

inoremap <c-space> <nop>

nnoremap Y y$

" Movement
noremap H ^
noremap L $
map <tab> %

nnoremap <leader>db <c-w>o<c-w>v
" Since minibufexpl is removed
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" Enable matchit
runtime macros/matchit.vim

" for Command-T
let g:CommandTMaxHeight = 10
let g:CommandTBackspaceMap = ['<BS>', '<C-h>']
let g:CommandTCursorLeftMap = '<Left>'
nnoremap <leader>ft :CommandTFlush<enter>
set wildignore+=*.jpg,*.gif,*.png,*.pyc,*.pyo,*.ptlc
set wildignore+=node_modules
set suffixes+=.log

nmap <F1> <nop>

" Since I'm a plugin author now
nnoremap <leader>so :source %<CR>

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
