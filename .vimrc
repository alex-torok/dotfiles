" Automatically install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" File Switching
Plug 'vim-scripts/a.vim'
Plug 'scrooloose/nerdtree'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install --bin' }
Plug 'junegunn/fzf.vim'
"
" Searching
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'

" External Integrations
Plug 'tpope/vim-fugitive'

" Look & Feel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
" Plug 'herrbischoff/cobalt2.vim'
Plug 'w0ng/vim-hybrid'
Plug 'tomasr/molokai'
Plug 'jaxbot/semantic-highlight.vim'
" Plug 'altercation/vim-colors-solarized'
" Plug 'vim-utils/vim-troll-stopper' "Highlight characters that arent as they appear
" Plug 'nathanaelkane/vim-indent-guides'

" Tmux-Related Integrations
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Basic Enhancements
Plug 'djoshea/vim-autoread'
Plug 'moll/vim-bbye'
" Plug 'vim-scripts/vim-auto-save'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-repeat'
" Plug 'unblevable/quick-scope'


call plug#end()


"**************************************
" Important globals
"**************************************
" Leader key is space
let mapleader = "\<Space>"

"**************************************
" Vimux
"**************************************
nnoremap <Leader>r :VimuxRunLastCommand<CR>

"**************************************
" Ag
"**************************************
" let g:ag_working_path_mode="r"

" use * to search current word in normal mode
" nnoremap * <Plug>AgActionWord
" use * to search selected text in visual mode
" vnoremap * <Plug>AgActionVisual

"**************************************
" Troll Stopper Highlighting
"**************************************
" highlight TrollStopper ctermbg = red guibg = #FF0000
"**************************************
" tagbar
"**************************************
nnoremap <Leader>t :TagbarToggle<CR>

"**************************************
" vim-bbye
"**************************************
:nnoremap <Leader>q :Bdelete<CR>

"**************************************
" Undo Tree
"**************************************
nnoremap <Leader>u :UndotreeToggle<CR>:UndotreeFocus <CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2

"**************************************
" Quick Scope
"**************************************
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"**************************************
" Airline
"**************************************
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"**************************************
" EasyMotion
"**************************************
" map <Leader><Leader> <Plug>(easymotion-prefix)

"**************************************
" Color
"**************************************
set background=dark
let g:molokai_original = 1
colorscheme molokai
autocmd VimEnter * :AirlineTheme monochrome

"**************************************
" a.vim
"**************************************
nnoremap <Leader><Tab>  :A<cr>
" a.vim has some really dumb mappings that we need to remove, but we need
" to wait until vim has loaded to unmap them
autocmd VimEnter * :iunmap <Space>ihn
autocmd VimEnter * :iunmap <Space>is
autocmd VimEnter * :iunmap <Space>ih

autocmd VimEnter * :nunmap <Space>ihn
autocmd VimEnter * :nunmap <Space>is
autocmd VimEnter * :nunmap <Space>ih
"**************************************
" vim-tmux-navigator
"**************************************
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

"better than ctrlp
nnoremap <Leader>o :GFiles --cached --others --exclude-standard<cr>
nnoremap <Leader>b :Buffers<cr>

"**************************************
" Autosave
"**************************************

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
"**************************************
" CtrlP
"**************************************
"nnoremap <Leader>b :CtrlPBuffer<CR>
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'
"let g:ctrlp_clear_cache_on_exit=0
"
"let g:ctrlp_max_files=80000
"let g:ctrlp_custom_ignore = {
"    \ 'dir': 'work/ecos2\|'
"    \ . 'work/epic\|'
"    \ . 'work/ltib\|'
"    \ . 'work/u-boot-imx6\|'
"    \ . 'work/hst/targets\|'
"    \ . 'mts\.\(\d\d\d\d\|module\)' ,
"    \ 'file': '\.\(a\|so\|o\)$\|'
"    \ . 'tar\.\(bz2\|gz\)$',
"    \ }
"let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"**************************************
" NERDTree
"**************************************

let NERDTreeShowHidden=1

" Automatically open NERDTree
" autocmd vimenter * NERDTree
" autocmd vimenter * wincmd p

" Quit vim if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


nnoremap <Leader>f :NERDTreeFind<CR>
nnoremap <Leader>m :NERDTreeToggle<CR>
"**************************************
" vim-indent-guides
"**************************************

" " Enable indent guides by default
" let g:indent_guides_enable_on_vim_startup = 1
"
" " Look and feel
" let g:indent_guides_auto_colors = 1
" let g:indent_guides_guide_size = 1
" let g:indent_guides_start_level = 2
"
" " Disable on certain filetypes
" let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

"**************************************
" Vim settings
"**************************************
" :set spell spelllang=en_us
" autocomplete in the command menu
set wildmenu
set wildchar=<Tab>
set wildmode=full

set colorcolumn=81

" 4 spaces for indentation
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set smarttab
set autoindent
filetype plugin indent on
" enable omnicompletion
set omnifunc=syntaxcomplete#Complete

" Don't warn me when switching buffers
set hidden
" Keep 3 lines below and above the cursor
set scrolloff=8
set sidescrolloff=10

set laststatus=2

" Show tabs and trailing whitespace
set list
set listchars=tab:▸-,precedes:←,extends:→,nbsp:·,trail:•

set nowrap
set sidescroll=1

set nocompatible " Disable vi-compatability
set encoding=utf-8
set t_Co=256
syntax enable

set backspace=indent,eol,start
set complete-=i

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

"Show line numbers
set number

" Mouse mode
set mouse=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Live search
set incsearch
set ignorecase
set hlsearch

" split views go below or to the right
set splitright
set splitbelow

" create swap files every 10 keystrokes
set updatecount=10
"**************************************
" Keybinds
"**************************************

nnoremap <Leader>tw :%s/\s\+$//e<CR>

" Ctrl-s saves the file
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Save all
nnoremap <Leader>w :wa<CR>

" Highlight our current line
set cursorline

" allow backspace through everything
set backspace=indent,eol,start
" let's speed some stuff up
set lazyredraw
set ttyfast

nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>

" kill that stupid window that pops up
map q: :q

let g:semanticTermColors = [1,2,3,4,5,6,7,8,9,10,12,13,14,15]
nnoremap <Leader>s :SemanticHighlightToggle<cr>

" Automatically save after exiting insert mode

"**************************************
" Persistent undo
"**************************************

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

"**************************************
" cscope
"**************************************
source ~/.cscope_maps.vim

"**************************************
" Autocommands
"**************************************
" Highlight cursorline only in active window
aug CursorLine
    autocmd!
    autocmd VimEnter * setl cursorline
    autocmd WinEnter * setl cursorline
    autocmd BufWinEnter * setl cursorline
    autocmd WinLeave * setl nocursorline
aug END
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

function! Delete()
    call inputsave()
    let movement = getchar()
    call inputrestore()
    execute "normal! d" . movement
    call NumberToggle()
endfunction

" Folding
"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1

