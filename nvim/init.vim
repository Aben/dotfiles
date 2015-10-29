call plug#begin('~/.nvim/bundle/')

Plug '5long/ryve'
Plug '5long/ragain'
Plug '5long/vim-imtoggle'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'kien/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/syntastic'
Plug 'bufkill.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'reinh/vim-makegreen'
Plug 'benmills/vimux'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'
Plug 'justinmk/vim-sneak'

Plug 'tpope/vim-endwise'
Plug 'mattn/emmet-vim'
Plug '5long/pytest-vim-compiler'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'kurayama/systemd-vim-syntax'

call plug#end()

let g:plug_threads = 5

runtime macros/matchit.vim

set exrc
set secure

let g:mapleader=','
let g:maplocalleader=' '

let g:lucius_style = 'blue'
if !has('gui_running')
  set t_Co=256
endif
colorscheme lucius

nnoremap <leader>hc :call ToggleCommentHighlight()<CR>
let s:comment_highlighting = 0
function! ToggleCommentHighlight()
  if s:comment_highlighting
    let s:comment_highlighting = 0
    colorscheme lucius
    return
  endif

  let s:comment_highlighting = 1
  hi Comment guifg=#bcbcbc gui=none
  hi Comment ctermfg=250 cterm=none
endfunction

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

set history=300
set cmdheight=2
set showcmd
set wildmode=longest:full,full
set wildignorecase
set completeopt=menu,preview,longest
set laststatus=2
set statusline=\ %f%m%R%H%W\ in\ %{CurDir()}\ \ Cur:%l/%L:%c
set fillchars=""
set shortmess+=aI

function! CurDir()
  let curdir = substitute(getcwd(),$HOME,'~','g')
  return curdir
endfunction

set ignorecase smartcase infercase
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
nnoremap <leader>dd :BD<CR>
nnoremap <leader>da :silent bufdo BD<CR>

nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <leader>lc :lcd %:p:h<CR>
nnoremap <leader>gg :Ack! 
nnoremap <leader>gf :AckFile 
nmap <leader>r <Plug>RagainRun
nmap <leader>R <Plug>RagainResetAndRun
nmap <leader>mr :RagainSetAndRun  <c-r>=expand('%')<CR><s-left><left>
nnoremap <leader>T :RagainSetAndRun MakeGreen <c-r>=expand("%")<CR><CR>
nnoremap <leader>mm :RagainSetAndRun make

set fileformats=unix,dos,mac
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb-18030,gbk,gb2312,latin1
set nobomb

set diffopt=filler,vertical,iwhite
noremap <leader>du :diffupdate<CR>

set noesckeys

nmap <c-s> <Plug>Ysurround
xmap s <Plug>VSurround
imap <c-s> <Plug>ISurround
inoremap $<space> <space><space><left>
inoremap $@ ()<left>
inoremap $2 []<left>
inoremap $# {}<left>
inoremap $3 <><left>
inoremap $4 {}<left><CR><esc>O
inoremap $$ $
inoremap $e ''<left>
inoremap $E ""<left>
inoremap $R <backspace><delete>

inoreabbrev rt return

noremap n' :<C-U>call <SID>TextObjNext("'")<CR>
nunmap n'
noremap n" :<C-U>call <SID>TextObjNext('"')<CR>
nunmap n"

function! s:TextObjNext(type)
  let l:cmd = printf('normal! /%s
  exec cmd
endfunction

function! EnterHit()
  if stridx(&buftype, 'quickfix') != -1
    normal! 
  else
    normal! a r
  endif
endfunction

nnoremap <CR> :call EnterHit()<CR>
autocmd vimrc QuickFixCmdPost make below cwindow

set pastetoggle=<f5>

" Leave <c-h> for backspace
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
inoremap <c-e> <c-o>A
inoremap <c-a> <c-o>I

nnoremap <c-n> :tabe \| lcd ~/

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


let g:ctrlp_map = '<leader>f'
let g:ctrlp_reuse_window = 'netrw\|help\|nofile'
if executable('ag')
  let g:ackprg = 'ag --vimgrep --follow -S'
  let g:ctrlp_user_command = 'ag --nocolor -g "" %s'
endif
nnoremap <leader>pf :CtrlPClearCache<CR>
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.jpg,*.gif,*.png,*.pyc,*.pyo,*.ptlc
set wildignore+=*.class,*.dex,*.apk,*.jar,*.idx,*.bin,*/build/*
set wildignore+=*.tgz,*.tar.gz,*.tar.xz,*.tar.bz2,*.zip
set wildignore+=node_modules
set wildignore+=_site
set wildignore+=*.o,*.so
set wildignore+=pkg,*.gem
set suffixes+=.log

let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['puppet', 'scala', 'html', 'asciidoc'],}
let g:syntastic_python_checkers=['pyflakes']

autocmd vimrc FileType css imap <c-u> <plug>(emmet-expand-abbr)
let g:user_emmet_settings = {
      \ 'html': {
      \ 'indentation': '  '
      \ }
      \ }

let g:tcommentMapLeader1 = ''
let g:tcommentMapLeader2 = ''

nnoremap <buffer> <leader>vp yip:call VimuxSendExpr(@@)<cr>
inoremap <buffer> <c-v><cr> <esc>yip:call VimuxSendExpr(@@)<cr>'}2o<esc>i

autocmd vimrc VimEnter * if empty(expand('%')) | setl buftype=nofile

let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

let g:slimv_repl_split = 4
let g:slimv_leader = '<space>'
let g:paredit_mode = 0

" Since I'm a plugin author now
nnoremap <leader>so :source %<CR>

command! CN IMEnable

let s:localrc = expand('<sfile>') . '.local'
if filereadable(s:localrc)
  exec "source " . fnameescape(s:localrc)
endif