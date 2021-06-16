set nocompatible
scriptencoding utf-8

" plugin manager setup

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.local/share/nvim/plugged')

" async
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" plugins
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'editorconfig/editorconfig-vim'


" ui
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Yggdroot/indentLine'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'easymotion/vim-easymotion'
"Plug 'chrisbra/Colorizer'


" search / replace
Plug 'troydm/asyncfinder.vim'
Plug 'Shougo/unite.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'

" completion
Plug 'Shougo/deoplete.nvim'


" comments
Plug 'tpope/vim-commentary'

" surround
Plug 'tpope/vim-surround'

" git
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" linting
Plug 'neomake/neomake'


" languages
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'udalov/kotlin-vim'

" initialize plugin system
call plug#end()

filetype plugin indent on

" end dein plugin manager setup

" functions

" delete trailing whitespace
func! RemoveUnwantedSpaces()
  exe "normal mz"
  %s/\s\+$//ge
  " %s/\%u00a0/ /ge
  " :retab
  exe "normal `z"
endfunc

function! AskQuit (msg, options, quit_option)
  if confirm(a:msg, a:options) == a:quit_option
    exit
  endif
endfunction

function! EnsureDirExists ()
  let required_dir = expand("%:h")
  if !isdirectory(required_dir)
    call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
          \       "&Create it\nor &Quit?", 2)

    try
      call mkdir( required_dir, 'p' )
    catch
      call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
    endtry
  endif
endfunction



function! LastPos()
  if &ft =~ 'gitcommit'
    call setpos('.',0)
    return
  endif
  if line("'\"") > 0 && line("'\"") <= line("$") |
    exe "normal! g`\"" |
  endif
endfunction

if !exists("*ReloadVimConfig")
  function! ReloadVimConfig ()
    let current_location = getpos('.')
    :so $MYVIMRC
    :echo "reloaded " $MYVIMRC
    call setpos('.', current_location)
  endfunction
  command! Recfg call ReloadVimConfig()
endif


augroup filetypedetect
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

" autocmd
autocmd BufWrite * :call RemoveUnwantedSpaces()
augroup AutoMkdir
  autocmd!
  autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END
autocmd BufReadPost * :call LastPos()
highlight ExtraWhitespace ctermbg=red guibg=red
" the following pattern will match trailing whitespace, except when typing at
" the end of a line.
match ExtraWhitespace /\s\+\%#\@<!$/
" show leading whitespace that includes spaces, and trailing whitespace.
"autocmd BufWinEnter * match ExtraWhitespace /^\s* \s*\|\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/



" buffer/file settings
set history=10000
set nobackup
set nowb
set noswapfile
set undofile
set undodir=$HOME/.config/nvim/.undo
" disable creation of .netwrhist files
let g:netrw_dirhistmax = 0

" clipboard
set clipboard+=unnamed
" set clipboard+=unnamedplus
set nopaste

" ui
set noshowmode
" TODO: NVIM_TUI_ENABLE_TRUE_COLOR now a noop? replaced by set termguicolors?
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set termguicolors
" set background=dark
set background=dark


" https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
" https://deductivelabs.com/en/2016/03/using-true-color-vim-tmux/
" http://ethanschoonover.com/solarized/vim-colors-solarized
colorscheme solarized
let g:solarized_degrade = 1
" let g:solarized_bold = 1
" let g:solarized_termtrans = 1
" let g:solarized_contrast = 'low'
" let g:solarized_contrast = 'normal'
" let g:solarized_contrast = 'high'
"colorscheme default
call togglebg#map("<F5>")


" search
set ignorecase
set smartcase
set incsearch
set nohlsearch

" general
set ts=2
set sw=2
set expandtab
set smarttab
set autoindent
set smartindent
set wildmenu
set wildmode=full
set wildignore+=*.o,*.out,*.obj,*.class,*.pyc,*.swp
set wildignore+=*.git,*.svn
set laststatus=2
set nu
set list
set hidden
set ruler
set nowrap
set lazyredraw
set so=10
set mouse-=a
set iskeyword-=_
syntax on

set virtualedit=block

set viminfo^=%

" plugin settings


let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
map  <Leader>f <Plug>(easymotion-bd-f)
" nmap <leader>s <Plug>(easymotion-overwin-f)
nmap <leader>s <Plug>(easymotion-overwin-f2)
map <leader>L <Plug>(easymotion-bd-jk)
nmap <leader>L <Plug>(easymotion-overwin-line)
map  <leader>W <Plug>(easymotion-bd-w)
nmap <leader>W <Plug>(easymotion-overwin-w)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map n <Plug>(easymotion-next)
map N <Plug>(easymotion-prev)
map <leader>l <Plug>(easymotion-lineforward)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader>h <Plug>(easymotion-linebackward)


" snippets
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
autocmd FileType setlocal completeopt+=noselect,menu,preview
set completeopt+=noselect,menu,preview

" colorizer
" let g:colorizer_auto_color = 1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

" indentline
" let g:indentLine_char='│'
let g:indentLine_char='│'

" gitgutter
let g:gitgutter_max_signs = 1000  " default value

" deoplete
let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#enable_refresh_always = 1
" call deoplete#custom#set('buffer', 'mark', 'buffer')
" call deoplete#custom#set('omni', 'mark', 'omni')
" call deoplete#custom#set('file', 'mark', 'file')
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.html = ''

" neomake
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_list_height = 2

let g:neomake_typescript_tscreact_maker = { 'exe' : 'tsc', 'args'  : [ '--jsx', 'react' ] }
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_typescript_enabled_makers = ['tslint', 'tscreact']
" let g:neomake_typescript_tslint_maker = { 'exe' : 'tslint', 'args': ['--jsx'] }
" let g:neomake_typescript_enabled_makers = ['tslint']

" NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeWinSize=45
let g:NERDTreeAutoDeleteBuffer=1

" unite
let g:unite_data_directory='~/.config/nvim/.cache/unite'
let g:unite_source_history_yank_enable=1
let g:unite_prompt='❯ '
" let g:unite_prompt='> '
" let g:unite_source_rec_async_command  = ['ag', '-p', '/home/kalvatn/.agignore', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
let g:unite_source_rec_neovim_command = ['ag', '-f', '--nocolor', '--nogroup', '--hidden', '-g', '']
" let g:unite_source_grep_command = 'ag'
" let g:unite_source_grep_default_opts = '-t -f --hidden --nogroup --nocolor --column -l'
" let g:unite_source_grep_recursive_opt = ''
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
" call unite#custom#source('file_rec/async','sorters','sorter_rank')
call unite#custom#source('file_rec/neovim','sorters','sorter_rank')
" nnoremap <silent> <c-p> :Unite -auto-resize -start-insert -direction=botright file_rec/async:!<CR>
" nnoremap <silent> <c-p> :Unite -auto-resize -start-insert -direction=botright file_rec/neovim:!<CR>

" nnoremap <silent> <c-F> :Unite -auto-resize -start-insert -direction=botright grep:!<CR><CR>
" nnoremap <silent> <leader>o :Unite -winwidth=45 -vertical -direction=botright outline<CR>

" custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction

" fzf
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden -f -l -g ""'
endif
let $FZF_DEFAULT_OPTS .= ' --inline-info'
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~40%',
  \ 'sink':    'Explore'})

nnoremap <silent> <c-p> :FZF<CR>

" elm
let g:polyglot_disabled = ['elm']
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1


" mappings/keybindings (https://neovim.io/doc/user/intro.html#key-notation)


" set <leader> key
let g:mapleader = ','


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
inoremap   <Space>


" align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" toggle comment
nmap <leader>c gcc
vmap <leader>c gc

" toggle folds
" nnoremap <leader>f za
" nnoremap <silent> <leader>f @=(foldlevel('.')?'za':"\<Space>")<CR>
" vnoremap <leader>f zf
" augroup XML
"     autocmd!
"     autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
" augroup END

" map CTRL+k/j to move up/down in popupmenu
inoremap <expr><C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<Up>" : "\<C-k>"

" reload vimrc
nnoremap <leader>r :call ReloadVimConfig()<cr>
" nnoremap <silent> <leader>l :set list!<cr>
" toggle line numbers
"nnoremap <silent> <leader>n :set nu!<cr>
nnoremap <silent> <leader>n :next<cr>
nnoremap <silent> <leader>N :prev<cr>
nnoremap <silent> <leader>v :vsplit<cr>
nnoremap <silent> <leader>- :split<cr>

" move to last character of pasted content
noremap <silent> p :set paste<cr>o<Esc>gp<Esc>:set nopaste<cr>
noremap <silent> P :set paste<cr>o<Esc>gP<Esc>:set nopaste<cr>
" paste from clipboard
" map <silent> <leader>p :set paste<cr>o<Esc>"+]p<Esc> :set nopaste<cr>
" map <silent> <leader>p :set paste<cr>o<Esc>p<Esc> :set nopaste<cr>
map <silent> <leader>t :tabnew<cr>
" quicksave
nnoremap <leader>w :w<cr>
" quickreload
nnoremap <leader>e :e<cr>
" search
" nnoremap <leader>s /
" toggle search highlighting
map <silent> <cr> :set nohlsearch!<cr>

nnoremap <silent> r <Nop>
inoremap <silent> <C-r> <Nop>

map <A-1> :NERDTreeToggle<cr>

nnoremap <silent> <leader>u :PlugInstall --sync<bar>:source $MYVIMRC<bar>:UpdateRemotePlugins<CR><bar>:PlugUpdate<bar>:PlugUpgrade<CR>

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" Disable Deoplete when selecting multiple cursors starts
function! Multiple_cursors_before()
    if exists('*deoplete#disable')
        exe 'call deoplete#disable()'
    elseif exists(':NeoCompleteLock') == 2
        exe 'NeoCompleteLock'
    endif
endfunction

" Enable Deoplete when selecting multiple cursors ends
function! Multiple_cursors_after()
    if exists('*deoplete#enable')
        exe 'call deoplete#enable()'
    elseif exists(':NeoCompleteUnlock') == 2
        exe 'NeoCompleteUnlock'
    endif
endfunction

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9


" language settings

" clojure
let g:rainbow#blacklist = [233, 234]
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

" let g:incr = 0
" fu! Incr()
"   let g:incr = g:incr + 1
"   return g:incr
" endfu

