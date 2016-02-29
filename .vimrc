" Automatically install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/a.vim'
" Plug 'justincampbell/vim-eighties'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope'
" Plug 'jaxbot/semantic-highlight.vim'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'scrooloose/syntastic'
" Plug 'Valloric/YouCompleteMe', {'do': './install.py' }
call plug#end()
"**************************************
" Quick Scope
"**************************************
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"**************************************
" Airline
"**************************************
let g:airline#extensions#tabline#enabled = 1
"**************************************
" Eighties (Auto Buffer Resizing)
"**************************************
" let g:eighties_enabled = 1
" let g:eighties_minimum_width = 80
" let g:eighties_extra_width = 0 " Increase this if you want some extra room
" let g:eighties_compute = 1 " Disable this if you just want the minimum + extra
" let g:eighties_bufname_additional_patterns = ['fugitiveblame'] " Defaults to [], 'fugitiveblame' is only an example. Takes a comma delimited list of bufnames as strings.:
"**************************************
" EasyMotion
"**************************************
" map <Leader><Leader> <Plug>(easymotion-prefix)

"**************************************
" Solarized Color
"**************************************
set background=dark
colorscheme solarized

"**************************************
" a.vim
"**************************************
map <Leader><Tab>  :A<cr>

"**************************************
" vim-tmux-navigator
"**************************************
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
"**************************************
" CtrlP
"**************************************
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_clear_cache_on_exit=0

let g:ctrlp_max_files=80000
let g:ctrlp_custom_ignore = {
    \ 'dir': 'work/ecos2\|'
    \ . 'work/hst/targets\|'
    \ . 'work/epic\|'
    \ . '^mts\.' ,
    \ 'file': '\.a$' ,
    \ }
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
"**************************************
" NERDTree
"**************************************

" Automatically open NERDTree
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

" Quit vim if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

:set colorcolumn=80

" 4 spaces for indentation
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

set smarttab
set autoindent
filetype plugin indent on

" Don't warn me when switching buffers
set hidden
" Keep 3 lines below and above the cursor
set scrolloff=3
set sidescrolloff=3

set laststatus=2

" Show tabs and trailing whitespace
set list
set listchars=tab:▸-,trail:⊡

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

" Highlight search results
set hlsearch
" Live search
set incsearch

" split views go below or to the right
set splitright
set splitbelow

" create swap files every 10 keystrokes
set updatecount=10
"**************************************
" Keybinds
"**************************************


" Death to arrow keys!
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Ctrl-s saves the file
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Leader key is space
let mapleader = "\<Space>"

" Highlight our current line
set cursorline

" allow backspace through everything
set backspace=indent,eol,start
" let's speed some stuff up
set lazyredraw
set ttyfast

nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" kill that stupid window that pops up
map q: :q
