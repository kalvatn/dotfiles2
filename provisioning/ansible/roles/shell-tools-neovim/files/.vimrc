syntax on
filetype plugin indent on

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd w

autocmd VimEnter * call StartupCommands()
function StartupCommands()
  NERDTree
  wincmd w
endfunction

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'udalov/kotlin-vim'

call plug#end()

" display
set background=dark
set nu
set nolist
set hidden
set ruler
set nowrap
set lazyredraw
set scrolloff=10
set laststatus=2
set viminfo^=%

" paste
set nopaste

" history / undo
set history=10000
set nobackup
set nowb
set noswapfile
set undofile
set undodir=$HOME/.vimundo
let g:netrw_dirhistmax = 0

" search
set ignorecase
set smartcase
set incsearch
set nohlsearch

" indent
set ts=2
set sw=2
set expandtab
set smarttab
set autoindent
set smartindent

" completions
set wildmenu
set wildmode=full
set wildignore+=*.o,*.out,*.obj,*.class,*.pyc,*.swp
set wildignore+=*.git,*.svn
set completeopt=menu,preview










" plugin options

" fzf
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden -f -l -g ""'
endif
let $FZF_DEFAULT_OPTS .= ' --inline-info'






" keybinds
let g:mapleader = ','
map q :q!

nnoremap <silent> <leader>u :PlugInstall<bar>:PlugUpdate<CR>

" disable ex mode
nnoremap Q <nop>
" remap q from recording to :q
map q :q!
map Q :qall!
" remap visual mode EOL to g_ (EOL - newline character)
vmap $ g_
" remap SOL to first non-blank character
map 0 ^

" CTRL+d to delete line in insert mode
inoremap <c-d> <esc>ddi
" avoid nbsp on altgr+space
inoremap <Alt-Space> <Space>

" align blocks of text and keep them selected
vmap < <gv
vmap > >gv

nnoremap <silent> <leader>n :next<cr>
nnoremap <silent> <leader>N :prev<cr>
nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>- :split<cr>

nnoremap <silent> <leader>l :set list!<cr>

" quicksave
nnoremap <leader>w :w<cr>
" quickreload
nnoremap <leader>e :e<cr>
" search
nnoremap <leader>s /
" toggle search highlighting
map <silent> <cr> :set nohlsearch!<cr>

nnoremap <silent> r <Nop>
inoremap <silent> <C-r> <Nop>


" map CTRL+k/j to move up/down in popupmenu
inoremap <expr><C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<Up>" : "\<C-k>"

" tpope/vim-commentary
nmap <leader>c gcc
vmap <leader>c gc

" junegunn/fzf
nnoremap <silent> <c-p> :FZF<CR>
