call plug#begin()

" Colorz!
Plug 'NLKNguyen/papercolor-theme'

" Editing / Operator / Everyday command
Plug '5long/ryve'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tomtom/tcomment_vim'
Plug 'cohama/lexima.vim'

if isdirectory($HOME . '/.fzf')
  Plug '~/.fzf'
  Plug 'junegunn/fzf.vim'
endif

" Make Vim Better
Plug '5long/vim-imtoggle'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-sayonara'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'neomake/neomake'

" Make-vim-more-like-IDE

Plug '5long/ragain'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mileszs/ack.vim'

" Filetype-wise
Plug '5long/pytest-vim-compiler'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'kurayama/systemd-vim-syntax'

" Not used that much, might be deleted / re-learnt
Plug 'benmills/vimux'
Plug 'tpope/vim-projectionist'

call plug#end()

let g:plug_threads = 5

runtime macros/matchit.vim

set exrc
set secure

let g:mapleader=','
let g:maplocalleader=' '

let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [], [ 'readonly', 'cwd', 'filename', 'modified' ] ],
  \   'right': [ [ 'neomake' ],
  \              [ 'lineinfo' ],
  \              [ 'filetype' ] ],
  \ },
  \ 'inactive': {
  \   'right': [ [],
  \              [ 'lineinfo' ],
  \              [] ],
  \ },
  \ 'component_function': {
  \   'cwd': 'CurDir',
  \ },
  \ 'component_expand': {
  \   'neomake': 'LightLineNeomake',
  \ },
  \ 'component_type': {
  \   'neomake': 'error',
  \ },
  \ }

hi link SneakPluginTarget Search
hi link SneakStreakTarget Search

colorscheme PaperColor

set nomodeline

set relativenumber
set lazyredraw

set switchbuf=usetab
nnoremap <leader><leader> <c-^>

set scrolloff=6
set cursorcolumn cursorline
set showmatch
set list
set listchars=tab:›\ ,trail:·
set linebreak
set textwidth=75
set formatoptions+=B1
set cpoptions+=J

set shiftround
set expandtab
for s:key in ['tabstop', 'shiftwidth', 'softtabstop']
  exec 'set ' . s:key . '=2'
endfor
unlet s:key

augroup vimrc
  autocmd!
augroup end

" Set the damn file type
nnoremap <LocalLeader><LocalLeader> :setfiletype<space>
let g:javascript_ignore_javaScriptdoc = 1
let g:vim_markdown_folding_disabled = 1

" Indentation
nnoremap <LocalLeader>i2 :setl ts=2 sw=2 sts=2<CR>
nnoremap <LocalLeader>i4 :setl ts=4 sw=4 sts=4<CR>
nnoremap <LocalLeader>et :setl et!<CR>

function! CmdlineKillTillEnd()
  return strpart(getcmdline(), 0, getcmdpos())
endfunction

cnoremap <C-A> <Home>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <c-k> <c-\>eCmdlineKillTillEnd()<cr>
cnoremap %% <c-r>=expand('%:h').'/'<CR>
cnoremap <c-v>b <c-r>=expand('%:r')<CR>

set cmdheight=2
set showcmd
set wildmode=longest:full,full
set wildignorecase
set completeopt=menu,preview,longest
set shortmess+=aI
set noshowmode

let s:home = resolve($HOME)
function! CurDir()
  return substitute(getcwd(), '^' . s:home, '~', '')
endfunction

set ignorecase smartcase
nnoremap <backspace> :nohlsearch<CR>
noremap / /\v
noremap ? ?\v

for s:key in ['#', '*', 'n', 'N']
  exec printf('nnoremap %s %szz', s:key, s:key)
endfor
unlet s:key

set noswapfile
set nobackup
set nowritebackup
set hidden
set undofile
set undodir=~/.tmp
set undolevels=1000

autocmd vimrc FocusLost * silent! wall
set autowrite

nnoremap <leader>w :update<CR>
nnoremap QQ :qa!<CR>
nnoremap <leader>md :silent! call mkdir(expand('%:p:h'), 'p')<CR>

let g:BufKillActionWhenBufferDisplayedInAnotherWindow = 'kill'
let g:BufKillVerbose = 0
nnoremap <leader>dd :Sayonara!<CR>
nnoremap <leader>da :silent windo Sayonara!<CR>

nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>gg :Ack! 
nnoremap <leader>gf :AckFile 
nmap <leader>r <Plug>RagainRun
nmap <leader>R <Plug>RagainResetAndRun
nmap <leader>mr :RagainSetAndRun  <c-r>=expand('%')<CR><s-left><left>
nnoremap <leader>mm :RagainSetAndRun make

nnoremap <leader>tn :<c-u>tabe<CR>
nnoremap <leader>tc :<c-u>tcd %:p:h<CR>
nnoremap <leader>tq :<c-u>tabclose<CR>

set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

set diffopt=filler,vertical,iwhite
noremap <leader>du :diffupdate<CR>

set noesckeys

nnoremap <leader>f :Files<CR>

nmap <c-s> <Plug>Ysurround
xmap s <Plug>VSurround
imap <c-s> <Plug>ISurround

nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

inoreabbrev rt return

autocmd vimrc QuickFixCmdPost make below cwindow

set pastetoggle=<f5>

" Leave <c-h> for backspace
inoremap <c-j> <c-g>U<down>
inoremap <c-k> <c-g>U<up>
inoremap <c-l> <c-g>U<right>
inoremap <c-e> <c-g>U<c-o>A
inoremap <c-a> <c-g>U<c-o>I

nmap <F1> <nop>
nmap Q <nop>
inoremap <c-space> <nop>
inoremap <c-c> <esc>
nnoremap Y y$
noremap H ^
noremap L $
map <tab> %
noremap <c-p> <c-i>

nnoremap <leader>ov <c-w>o<c-w>v
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" neovim supports m-* mappings now
nnoremap <m-h> <c-w>h
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-l> <c-w>l


if executable('ag')
  let g:ackprg = 'ag --vimgrep --follow -S'
endif

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.jpg,*.gif,*.png,*.pyc,*.pyo,*.ptlc
set wildignore+=*.class,*.dex,*.apk,*.jar,*.idx,*.bin,*/build/*
set wildignore+=*.tgz,*.tar.gz,*.tar.xz,*.tar.bz2,*.zip
set wildignore+=node_modules
set wildignore+=_site
set wildignore+=*.o,*.so
set wildignore+=pkg,*.gem
set suffixes+=.log

let g:neomake_airline = 0
let g:neomake_place_signs = 0
let g:neomake_python_enabled_makers = ['pyflakes']
let g:neomake_javascript_enabled_makers = ['eslint']
autocmd vimrc BufWritePost * Neomake

fun! LightLineNeomake()
  return neomake#statusline#LoclistStatus()
endf

let g:tcommentMapLeader1 = ''
let g:tcommentMapLeader2 = ''

nnoremap <buffer> <leader>vp yip:call VimuxSendExpr(@@)<cr>
inoremap <buffer> <c-v><cr> <esc>yip:call VimuxSendExpr(@@)<cr>'}2o<esc>i

autocmd vimrc VimEnter * if empty(expand('%')) | setl buftype=nofile

let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Since I'm a plugin author now
nnoremap <leader>so :source %<CR>

command! CN IMEnable

let s:localrc = expand('<sfile>') . '.local'
if filereadable(s:localrc)
  exec 'source ' . fnameescape(s:localrc)
endif
