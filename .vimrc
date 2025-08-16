" ============================
"      БАЗОВЫЕ НАСТРОЙКИ
" ============================

" Включить синтаксис
syntax on

" Авто-определение типа файлов и авто-отступы
filetype plugin indent on

" Поддержка 256 цветов
set t_Co=256

" Светлый фон для корректного отображения цветов
set background=light

" ----------------------------
"      ТАБУЛЯЦИЯ И ОТСТУПЫ
" ----------------------------
set tabstop=3         " Количество пробелов, соответствующих табу
set softtabstop=3     " Количество пробелов для редактирования табов
set shiftwidth=3      " Количество пробелов при автоотступе
set expandtab         " Использовать пробелы вместо табов

" ----------------------------
"      НАВИГАЦИЯ И ПОИСК
" ----------------------------
set number            " Номера строк
set ruler             " Показ позиции курсора
set incsearch         " Инкрементальный поиск

" ----------------------------
"      СКЛАДКИ
" ----------------------------
set foldmethod=indent  " Складки по отступам
set foldlevel=99       " Все складки открыты по умолчанию
nnoremap <space> za    " Пробел переключает складку

" ----------------------------
"      АВТО-ОТСТУПЫ
" ----------------------------
set smartindent
set autoindent
set copyindent
set cindent

" ----------------------------
"      ОБНОВЛЕНИЕ И ВРЕМЯ
" ----------------------------
set updatetime=300    " Быстрое обновление для Coc и подсветки

" ============================
"      CLion LIGHT COLOR SCHEME
" ============================

" Основной текст
highlight Normal ctermfg=black 

" Номера строк
highlight LineNr ctermfg=242 

" Фон текущей строки
highlight CursorLine ctermbg=254

" Комментарии (серый)
highlight Comment ctermfg=244

" Ключевые слова (тёмно-синий)
highlight Keyword ctermfg=20
highlight Statement ctermfg=20

" Строки (тёмно-красный)
highlight String ctermfg=124

" Числа (фиолетовый)
highlight Number ctermfg=92

" Функции (тёмно-коричневый)
highlight Function ctermfg=30

" Типы (тёмно-голубой)
highlight Type ctermfg=30

" Константы (фиолетовый)
highlight Constant ctermfg=92

" Операторы (чёрный)
highlight Operator ctermfg=black

" PreProc (include, define - тёмно-пурпурный)
highlight PreProc ctermfg=127

" Специальные символы (оранжевый)
highlight Special ctermfg=202

" Identifier
highlight Identifier ctermfg=94

" ============================
"      НАВИГАЦИЯ В INSERT MODE
" ============================
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" ============================
"      ПОДДЕРЖКА ПЛАГИНОВ
" ============================
call plug#begin('~/.vim/plugged')

" LSP Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Древовидная навигация
Plug 'preservim/nerdtree'

" Поиск файлов
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" ============================
"      COC.NVIM KEYBINDINGS
" ============================

" Принять выделенный вариант автодополнения
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Перемещение по элементам автодополнения
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

" Навигация по коду
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

" ============================
"      РУССКАЯ РАСКЛАДКА
" ============================

" Нижний регистр
noremap й q
noremap ц w
noremap у e
noremap к r
noremap е t
noremap н y
noremap г u
noremap ш i
noremap щ o
noremap з p
noremap х [
noremap ъ ]
noremap ф a
noremap ы s
noremap в d
noremap а f
noremap п g
noremap р h
noremap о j
noremap л k
noremap д l
noremap ж ;
noremap э '
noremap ё \
noremap я z
noremap ч x
noremap с c
noremap м v
noremap и b
noremap т n
noremap ь m
noremap б ,
noremap ю .

" Верхний регистр
noremap Й Q
noremap Ц W
noremap У E
noremap К R
noremap Е T
noremap Н Y
noremap Г U
noremap Ш I
noremap Щ O
noremap З P
noremap Х {
noremap Ъ }
noremap Ф A
noremap Ы S
noremap В D
noremap А F
noremap П G
noremap Р H
noremap О J
noremap Л K
noremap Д L
noremap Ж :
noremap Э "
noremap Я Z
noremap Ч X
noremap С C
noremap М V
noremap И B
noremap Т N
noremap Ь M
noremap Б <
noremap Ю >

" ============================
"      NERD TREE
" ============================
nnoremap <C-n> :NERDTreeToggle<CR>  " Открыть/закрыть NERDTree
nnoremap <C-f> :NERDTreeFind<CR>    " Найти текущий файл

let NERDTreeShowHidden=1
let g:NERDTreeWinSize = 55
" Внутри NERDTree можно динамически переключать видимость скрытых файлов клавишей I (Shift + i)
" ============================
"      ПОИСК ФАЙЛОВ И БУФЕРОВ
" ============================
" быстрый поиск
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" Следующий/предыдущий буфер
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

