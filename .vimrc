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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install --bin' }
Plug 'junegunn/fzf.vim'
" Plug 'mhinz/vim-startify'


" Searching
Plug 'majutsushi/tagbar'
" Plug 'rking/ag.vim'
" Plug 'Chun-Yang/vim-action-ag'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim'

" External Integrations
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Look & Feel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'sheerun/vim-polyglot'
Plug 'kien/rainbow_parentheses.vim'

" Colorschemes! 
Plug 'bcicen/vim-vice'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'herrbischoff/cobalt2.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim'

" Tmux-Related Integrations
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Basic Enhancements
Plug 'djoshea/vim-autoread'
Plug 'moll/vim-bbye'
Plug 'vim-scripts/vim-auto-save'
Plug 'tpope/vim-repeat'
Plug 'unblevable/quick-scope'
Plug 'AndrewRadev/linediff.vim'
Plug 'nickhutchinson/vim-cmake-syntax'
" Plug 'junegunn/vim-peekaboo'

call plug#end()

"**************************************
" Important globals
"**************************************
" Leader key is space
let mapleader = "\<Space>"

"**************************************
" Git Gutter
"**************************************
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_sign_column_always = 1

"**************************************
" FZF
"**************************************
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

command! FZFGFiles :call fzf#run({
\  'source':  'git ls-files --cached --others --exclude-standard',
\  'sink':    'edit',
\  'dir':     split(system('git rev-parse --show-toplevel || pwd'), '\n')[0],
\  'options': '--preview "git log --format=\"%ar %Cred(%cn) %Creset%s\" {} | head -'.&lines.' | cut -c1-'.&columns/2.' || (cat {}) 2> /dev/null | head -'.&lines.'"',
\  'down':    '40%'})

nnoremap <Leader>g :FZFGFiles<cr>

nnoremap <Leader>o :Files<cr>
nnoremap <Leader>b :Buffers<cr>

"**************************************
" Vimux
"**************************************
nnoremap <Leader>r :VimuxRunLastCommand<CR>

"**************************************
" tagbar
"**************************************
nnoremap <Leader>t :TagbarToggle<CR>

"**************************************
" vim-bbye
"**************************************
:nnoremap <Leader>q :Bdelete<CR>

"**************************************
" Rainbow Parenthesis
"**************************************
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"**************************************
" tpope/commentary
"**************************************
autocmd FileType cmake setlocal commentstring=#%s
"
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
" Color
"**************************************
set background=dark
let g:molokai_original = 1

color molokai

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

"**************************************
" Autosave
"**************************************

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
"**************************************
" NERDTree
"**************************************

let NERDTreeShowHidden=1

" Quit vim if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <Leader>f :NERDTreeFind<CR>
nnoremap <Leader>m :NERDTreeToggle<CR>

"**************************************
" Semantic colors
"**************************************

let g:semanticTermColors = [1,2,3,4,5,6,7,8,9,10,12,13,14,15]
nnoremap <Leader>s :SemanticHighlightToggle<cr>

"**************************************
" Vim settings
"**************************************

" autocomplete in the command menu
set wildmenu
set wildchar=<Tab>
set wildmode=full

" show vertical line at 81 characters
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

" Keep lines above/below and to left/right of cursor
set scrolloff=8
set sidescrolloff=10

" Enable statusline
set laststatus=2

" Show tabs and trailing whitespace
set list
set listchars=tab:▸-,precedes:←,extends:→,nbsp:·,trail:•

set nowrap
set sidescroll=5

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

nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

" Trim trailing whitespace
command! Chomp %s/\s\+$// | normal! ``
nnoremap <Leader>tw :Chomp<CR>

" Make Y behave like other commands
nnoremap Y y$

" Highlight our current line
set cursorline

" allow backspace through everything
set backspace=indent,eol,start

" let's speed some stuff up
set lazyredraw
set ttyfast

" switching between buffers
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>

" kill that stupid window that pops up
map q: :q

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
" aug CursorLine
"     autocmd!
"     autocmd VimEnter * setl cursorline
"     autocmd WinEnter * setl cursorline
"     autocmd BufWinEnter * setl cursorline
"     autocmd WinLeave * setl nocursorline
" aug END
