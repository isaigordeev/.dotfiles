" ============================================================
"                   VIM CONFIGURATION
" ============================================================
"'  Features:
" - Modern LSP support with CoC
" - File explorer with NERDTree
" - Fuzzy search with fzf
" - Easy commenting with NERDCommenter
" - Custom CLion-like light color scheme
" - Russian keyboard layout remapped for Vim commands
" - Tab and split management
" - Session saving and restoring

" ============================================================
"                      HOTKEYS
" ============================================================
" GENERAL
"   <leader>s        Save file
"   <leader>w        Quit file
"   <leader>W        Quit without saving
"   <leader>Q        Quit all
"   <leader>;        Command history
"   <leader>/        Search history
"   <leader>y        Yank to system clipboard
"   <leader>v        Reselect last visual selection

" SPLITS
"   <leader>e        Vertical split
"   <leader>r        Horizontal split
"   <leader>f        Keep only current split
"   <leader>h/j/k/l  Move between splits

" TABS
"   <leader>t        New tab
"   <leader>u        Previous tab
"   <leader>i        Next tab
"   <leader>1..9     Jump to tab N

" SESSIONS
"   <leader><Tab>    Save session
"   <leader><S-Tab>  Load session

" NERDTREE
"   <C-n>            Toggle NERDTree
"   <C-f>            Find current file in NERDTree
"   I                Show/hide hidden files
"   m                File management menu
"   o/i/s/t/go       Open file (normal/split/tab)
"   p/u/C/R          Parent, up, change root, refresh
"   za/zA/zo/zc      Folding commands

" FUZZY FIND
"   <C-p>            Search files
"   <C-b>            Search buffers

" COMMENTING
"   <C-/>            Toggle comment (normal/visual mode)

" COC (LSP)
"   <CR>             Confirm completion
"   <C-j>/<C-k>      Navigate completion menu
"   gd/gy/gi/gr      Go to definition/type/impl/references
"   K                Show documentation (hover)

" NAVIGATION
"   <space>          Toggle code fold
"   Insert mode:     <C-h/j/k/l> → Move cursor left/down/up/right


" ============================================================
"                    BASIC SETTINGS
" ============================================================

" Leader key
let mapleader = " "

" Enable syntax highlighting
syntax on

" Filetype detection, plugins and indent
filetype plugin indent on

" Enable 256 colors
set t_Co=256

" Light background for better colors
set background=light


" ----------------------------
"        TABS & INDENTS
" ----------------------------
set tabstop=3         " Number of spaces per tab
set softtabstop=3     " Number of spaces when editing tabs
set shiftwidth=3      " Spaces per auto-indent
set expandtab         " Use spaces instead of tabs

" ----------------------------
"        NAVIGATION & SEARCH
" ----------------------------
set number            " Show line numbers
set ruler             " Show cursor position
set incsearch         " Incremental search
set signcolumn=yes    " Always show sign column
highlight SignColumn ctermbg=NONE guibg=NONE


" ----------------------------
"        FOLDING
" ----------------------------
set foldmethod=indent " Fold based on indent level
set foldlevel=99      " Keep all folds open by default
nnoremap <space> za   " Toggle fold with <space>


" ----------------------------
"        AUTO-INDENT
" ----------------------------
set smartindent
set autoindent
set copyindent
set cindent


" ----------------------------
"        UPDATE & TIMING
" ----------------------------
set updatetime=300    " Faster update for Coc and highlighting


" ============================================================
"             CLION-LIKE LIGHT COLOR SCHEME
" ============================================================
highlight Comment   ctermfg=244   " Comments (gray)
" Optional:
"highlight String    ctermfg=124   
"highlight Number    ctermfg=92   
"highlight Function  ctermfg=30  
"highlight Type      ctermfg=30 
"highlight Constant  ctermfg=92  
"highlight Operator  ctermfg=black 
"highlight Special   ctermfg=202   
"highlight Normal   ctermfg=black
"highlight LineNr   ctermfg=242
"highlight CursorLine ctermbg=254
"highlight Keyword  ctermfg=45
"highlight Statement ctermfg=55
"highlight PreProc  ctermfg=127
"highlight Identifier ctermfg=94


" ============================================================
"               INSERT MODE NAVIGATION
" ============================================================
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>


" ============================================================
"                        PLUGINS
" ============================================================
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP
Plug 'preservim/nerdtree'                       " File tree
Plug 'junegunn/fzf', { 'do': './install --all' }" Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'                  " Commenting

call plug#end()


" ============================================================
"                    COC KEYBINDINGS
" ============================================================
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')


" ============================================================
"             RUSSIAN LAYOUT REMAPPING
" ============================================================
" Allows Vim commands on Russian keyboard layout
" (maps Cyrillic keys to Vim commands)

noremap й q | noremap ц w | noremap у e | noremap к r | noremap е t
noremap н y | noremap г u | noremap ш i | noremap щ o | noremap з p
noremap х [ | noremap ъ ] | noremap ф a | noremap ы s | noremap в d
noremap а f | noremap п g | noremap р h | noremap о j | noremap л k
noremap д l | noremap ж ; | noremap э ' | noremap ё \
noremap я z | noremap ч x | noremap с c | noremap м v
noremap и b | noremap т n | noremap ь m | noremap б , | noremap ю .

" Uppercase
noremap Й Q | noremap Ц W | noremap У E | noremap К R | noremap Е T
noremap Н Y | noremap Г U | noremap Ш I | noremap Щ O | noremap З P
noremap Х { | noremap Ъ } | noremap Ф A | noremap Ы S | noremap В D
noremap А F | noremap П G | noremap Р H | noremap О J | noremap Л K
noremap Д L | noremap Ж : | noremap Э " | noremap Я Z
noremap Ч X | noremap С C | noremap М V | noremap И B | noremap Т N
noremap Ь M | noremap Б < | noremap Ю >


" ============================================================
"                       NERD TREE
" ============================================================
nnoremap <C-n> :NERDTreeToggle<CR> " Toggle NERDTree
nnoremap <C-f> :NERDTreeFind<CR>   " Find current file
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=55
autocmd FileType nerdtree setlocal number

" ============================================================
"                      FUZZY FIND
" ============================================================
nnoremap <C-p> :Files<CR>    " Search files
nnoremap <C-b> :Buffers<CR>  " Search buffers


" ============================================================
"                      COMMENTING
" ============================================================
nnoremap <C-_> <Plug>NERDCommenterToggle " Toggle comment (normal mode)
vnoremap <C-_> <Plug>NERDCommenterToggle " Toggle comment (visual mode)


" ============================================================
"                          TABS
" ============================================================
nnoremap <leader>t :tabnew<CR>        " New tab
nnoremap <leader>u :tabprevious<CR>   " Previous tab
nnoremap <leader>i :tabnext<CR>       " Next tab

" Jump to tab 1–9
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt


" ============================================================
"                   FILE MANAGEMENT
" ============================================================
nnoremap <leader>s :w<CR>    " Save file
nnoremap <leader>w :q<CR>    " Quit file
nnoremap <leader>W :q!<CR>   " Quit without saving
nnoremap <leader>Q :qa<CR>   " Quit all

" Splits
nnoremap <leader>e :vsplit<CR> " Vertical split
nnoremap <leader>r :split<CR>  " Horizontal split
nnoremap <leader>f :only<CR>   " Keep only current split

" Move between splits
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l


" ============================================================
"                HISTORY & CLIPBOARD
" ============================================================
nnoremap <leader>; q:    " Command history
nnoremap <leader>/ q/    " Search history

vnoremap <leader>y "+y   " Yank to system clipboard
nnoremap <leader>v gv    " Reselect last visual selection


" ============================================================
"                        SESSIONS
" ============================================================
let g:session_file = expand('~/.vim/session.vim')

" Save session
nnoremap <leader><Tab> :mksession! ~/.vim/session.vim<CR>:echo "Session saved!"<CR>

" Load session
nnoremap <leader><S-Tab> :source ~/.vim/session.vim<CR>:echo "Session loaded!"<CR>


