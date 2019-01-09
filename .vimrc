" Folding {{{
" set foldmethod=marker
" set foldlevel=0
" set modelines=1
" }}}
" Automatically Install Plug {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}
" Plugin List {{{
call plug#begin('~/.vim/plugged')
" File Switching
Plug 'vim-scripts/a.vim'
Plug 'tpope/vim-vinegar'
Plug 'wincent/ferret'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tweekmonster/fzf-filemru'


" Searching
" Plug 'majutsushi/tagbar'
" Plug 'rking/ag.vim'
" Plug 'Chun-Yang/vim-action-ag'
Plug 'haya14busa/incsearch.vim'

" Editing
Plug 'w0rp/ale'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim'
Plug 'rhysd/vim-clang-format'
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Plug 'Valloric/YouCompleteMe'

" External Integrations
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'shime/vim-livedown'

" Look & Feel
" Plug 'bling/vim-bufferline'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

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
Plug 'tpope/vim-eunuch'
" Plug 'junegunn/vim-peekaboo'

" Code Syntaxes
Plug 'mfukar/robotframework-vim'
Plug 'nickhutchinson/vim-cmake-syntax'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'vim-scripts/txt.vim'

call plug#end()
" }}}
" Map Leader {{{
let mapleader = "\<Space>"
" }}}
" ALE (Async Lint Engine) {{{
let g:ale_linters = {
\ 'python': ['pyflakes'],
\ 'yaml': ['yamllint'],
\ 'dockerfile': ['hadolint'],
\ 'tcl': ['nagelfar'],
\ 'cpp': ['cppcheck', 'clangcheck', 'flawfinder'] }

let g:ale_c_build_dir_names = ["build/mts-5800-app-arm-cortex-a9"]
let g:ale_tcl_nagelfar_executable = "nagelfar"
" Disable Warnings and 'N'? errors
let g:ale_tcl_nagelfar_options = "-filter '*N *' -filter '*W *'"
autocmd FileType tcl setlocal ale_open_list = 1

nmap <silent> ]w <Plug>(ale_next_wrap)
nmap <silent> [w <Plug>(ale_previous_wrap)
" }}}
" Git Gutter {{{
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
set signcolumn=yes
" let g:gitgutter_highlight_lines = 1
let g:gitgutter_diff_args = '-w'

nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk
nmap <Leader>gv <Plug>GitGutterPreviewHunk
highlight link GitGutterDeleteLine NONE

" augroup GitGutterHighlight
"     autocmd ColorScheme hi DiffAdd    cterm=bold     ctermfg=NONE ctermbg=22
"     autocmd ColorScheme hi DiffDelete cterm=bold ctermfg=NONE ctermbg=88
"     autocmd ColorScheme hi DiffChange cterm=bold ctermfg=NONE ctermbg=24
"     autocmd ColorScheme hi DiffText   cterm=bold ctermfg=NONE ctermbg=darkyellow
" augroup END

"}}}
" Ulti-snips {{{

" " " Trigger configuration. Do not use <tab> if you use
" " " https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"


" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
" }}}
" FZF {{{
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

command! FZFGFiles :call fzf#run({
\  'source':  'git ls-files --cached --others --exclude-standard',
\  'sink':    'edit',
\  'dir':     split(system('git rev-parse --show-toplevel || pwd'), '\n')[0],
\  'options': '--preview "git log --format=\"%ar %Cred(%cn) %Creset%s\" {} | head -'.&lines.' | cut -c1-'.&columns/2.' || (cat {}) 2> /dev/null | head -'.&lines.'"',
\  'down':    '40%'})

" nnoremap <Leader>og :FZFGFiles<cr>

nnoremap <Leader>o :Files<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>r :FilesMru<cr>
" }}}
" Vimux {{{
nnoremap <Leader>r :VimuxRunLastCommand<CR>
" }}}
" tagbar {{{
nnoremap <Leader>t :TagbarToggle<CR>
" }}}
" vim-bbye {{{
:nnoremap <Leader>q :Bdelete<CR>
autocmd FileType netrw setl bufhidden=delete
autocmd FileType netrw :nnoremap <buffer> <Leader>q :bn<CR>
" }}}
" Rainbow Parenthesis {{{
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme,cpp RainbowParentheses
augroup END
" }}}
" tpope/commentary {{{
" autocmd FileType * set commentstring=#\ %s
autocmd FileType cmake let b:commentary_format='# %s'
autocmd FileType groovy let b:commentary_format='// %s'
autocmd FileType jinja let b:commentary_format='{# %s #}'
autocmd FileType robot let b:commentary_format='# %s'
"}}}
" Undo Tree {{{
nnoremap <Leader>u :UndotreeToggle<CR>:UndotreeFocus <CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2
" }}}
" Quick Scope {{{
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}
" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" }}}
" Color {{{
set background=dark
let g:molokai_original = 1

color molokai
" }}}
" vim-markdown {{{
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1
" }}}
" a.vim {{{
nnoremap <Leader><Tab>  :A<cr>
" a.vim has some really dumb mappings that we need to remove, but we need
" to wait until vim has loaded to unmap them
autocmd VimEnter * :iunmap <Space>ihn
autocmd VimEnter * :iunmap <Space>is
autocmd VimEnter * :iunmap <Space>ih

autocmd VimEnter * :nunmap <Space>ihn
autocmd VimEnter * :nunmap <Space>is
autocmd VimEnter * :nunmap <Space>ih
" }}}
" Autosave {{{

let g:auto_save_silent = 1
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
" }}}
" NERDTree {{{

let NERDTreeShowHidden=1

" Quit vim if NERDTree is the only buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <Leader>f :NERDTreeFind<CR>
nnoremap <Leader>m :NERDTreeToggle<CR>
" }}}
" Semantic colors {{{

let g:semanticTermColors = [1,2,3,4,5,6,7,8,9,10,11,13,15,46,51,199]
nnoremap <Leader>s :SemanticHighlightToggle<cr>
" }}}
" Search settings {{{
set incsearch
set ignorecase
set hlsearch

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" }}}
" Vim Settings {{{
" autocomplete in the command menu
set wildmenu
set wildchar=<Tab>
set wildmode=full

" show vertical line at 81 characters
set colorcolumn=80

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
set relativenumber
set number

" Mouse mode
set mouse=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" split views go below or to the right
set splitright
set splitbelow

" create swap files every 10 keystrokes
set updatecount=10
" }}}
" Keybinds {{{

nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

" Trim trailing whitespace
command! Chomp %s/\s\+$// | normal! ``
nnoremap <Leader>tw :Chomp<CR>

" Make Y behave like other commands
nnoremap Y y$
vnoremap Y :w !ssh macbook pbcopy<CR>

" Navigate to a buffer
nnoremap gb :ls<CR>:buffer<Space>

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

"}}}
" Persistent Undo {{{

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

" }}}
" cscope {{{
source ~/.cscope_maps.vim
" }}}
" Autocommands {{{

" Weird file extensions
autocmd BufNewFile,BufRead *.sls set ft=yaml
autocmd BufNewFile,BufRead Dockerfile* set ft=dockerfile
autocmd BufNewFile,BufRead Jenkinsfile* set ft=Jenkinsfile

au BufRead,BufNewFile grains set syntax=yaml

autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown setlocal wrapmargin=2

" Highlight cursorline only in active window
aug CursorLine
    autocmd!
    autocmd VimEnter * setl cursorline
    autocmd WinEnter * setl cursorline
    autocmd BufWinEnter * setl cursorline
    autocmd WinLeave * setl nocursorline
aug END

"Markdown settings
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0

" }}}
" clang-format {{{

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
let g:clang_format#command = "clang-format"
let g:clang_format#detect_style_file = 1
" }}}
" vim:foldmethod=marker:foldlevel=0
