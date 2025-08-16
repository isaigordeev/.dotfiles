" ----------------------------
"   Базовые настройки
" ----------------------------

" Включить синтаксис
syntax on

" Определение типа файлов и авто-отступов
filetype plugin indent on

" Поддержка 256-цветной палитры
set t_Co=256

" Светлый фон, чтобы цвета выглядели корректно
set background=light

" Табуляция и отступы
set tabstop=3
set softtabstop=3
set shiftwidth=3
set expandtab

" Номера строк
set number

" Инкрементальный поиск
set incsearch

" Складки по отступам
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Показ позиции курсора
set ruler

" Авто-отступы
set smartindent
set autoindent
set copyindent
set cindent

" Время обновления для Coc и подсветки
set updatetime=300

" ----------------------------
"   CLion Light Цветовая схема
" ----------------------------

" Основной текст
highlight Normal ctermfg=black 

" Номера строк
highlight LineNr ctermfg=242 
" highlight CursorLineNr ctermfg=32 ctermbg=254

" Фон текущей строки
highlight CursorLine ctermbg=254

" Комментарии (серый)
highlight Comment ctermfg=244

" Ключевые слова (тёмно-синий, как в CLion)
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

" ----------------------------
"   Навигация в Insert Mode
" ----------------------------
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" ----------------------------
"   Поддержка плагинов
" ----------------------------
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" ----------------------------
"   Coc.nvim keybindings
" ----------------------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
autocmd CursorHold * silent call CocActionAsync('highlight')

" ----------------------------
"   Русская раскладка (основные привязки)
" ----------------------------
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
