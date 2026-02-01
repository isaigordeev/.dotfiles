" Filename: dark_vscode.vim
" Description: VSCode Dark theme ported to Vim with termguicolors

if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'vs_dark'
set background=dark
set termguicolors

" Editor colors
hi Normal       guifg=#D4D4D4 guibg=#2f2f2f
hi CursorLine   guibg=#2A2A2A
hi Visual       guibg=#3A3D41
hi LineNr       guifg=#6B6B6B guibg=#2f2f2f
hi CursorLineNr guifg=#FFFFFF guibg=#1E1E1E
hi StatusLine   guifg=#D4D4D4 guibg=#007ACC
hi StatusLineNC guifg=#BBBBBB guibg=#1E1E1E
hi VertSplit    guifg=#454545 guibg=#1E1E1E
hi Pmenu        guifg=#CCCCCC guibg=#252526
hi PmenuSel     guifg=#FFFFFF guibg=#0078D4
hi PmenuSbar    guibg=#454545
hi PmenuThumb   guibg=#007ACC

" Comments
hi Comment      guifg=#828282 gui=italic

" Constants
hi Constant     guifg=#569CD6
hi Number       guifg=#B5CEA8
hi Boolean      guifg=#569CD6
hi String       guifg=#CE9178
hi Character    guifg=#CE9178
hi Float        guifg=#B5CEA8
hi SpecialChar  guifg=#D16969

" Keywords
hi Keyword      guifg=#569CD6
hi Conditional  guifg=#569CD6
hi Repeat       guifg=#569CD6
hi Exception    guifg=#569CD6
hi Operator     guifg=#D4D4D4
hi PreProc      guifg=#569CD6
hi Include      guifg=#569CD6
hi Define       guifg=#569CD6
hi Macro        guifg=#569CD6
hi Type         guifg=#569CD6
hi StorageClass guifg=#569CD6
hi Structure    guifg=#569CD6
hi Typedef      guifg=#569CD6

" Functions
hi Function     guifg=#D4D4D4
hi Identifier   guifg=#569CD6
hi Method       guifg=#D4D4D4
hi Statement    guifg=#569CD6

" Tags and markup
hi Tag          guifg=#569CD6
hi Label        guifg=#569CD6
hi Special      guifg=#569CD6
hi Delimiter    guifg=#808080
hi Title        guifg=#569CD6 gui=bold
hi Bold         gui=bold
hi Italic       gui=italic
hi Underlined   gui=underline
hi Error        guifg=#F44747 guibg=#1E1E1E gui=bold
hi Todo         guifg=#B5CEA8 guibg=NONE gui=bold 

" Diff
hi DiffAdd      guifg=#B5CEA8 guibg=#1E1E1E
hi DiffChange   guifg=#569CD6 guibg=#1E1E1E
hi DiffDelete   guifg=#CE9178 guibg=#1E1E1E
hi DiffText     guifg=#569CD6 guibg=#1E1E1E

" Match parentheses
hi MatchParen   guibg=#264F78

" Search
hi Search       guifg=#D4D4D4 guibg=#264F78
hi IncSearch    guifg=#D4D4D4 guibg=#0078D4

" Terminal colors
hi Terminal     guifg=#D4D4D4 guibg=#1E1E1E

" Popup and floating windows
hi FloatBorder  guifg=#303031
hi NormalFloat  guifg=#D4D4D4 guibg=#1E1E1E

" Set folder color (optional)
hi NERDTreeDir guifg=#569CD6 gui=bold

" Directory and NERDTree arrows/bullets (lighter blue for readability)
hi Directory          guifg=#87CFFF
hi NERDTreeOpenable   guifg=#87CFFF
hi NERDTreeClosable   guifg=#87CFFF
hi NERDTreeDirSlash   guifg=#87CFFF
hi NERDTreeUp         guifg=#87CFFF

" CoC error/warning highlights (colored text, no background)
hi CocErrorHighlight   guibg=NONE guifg=#F44747 gui=undercurl guisp=#F44747 cterm=underline ctermfg=Red
hi CocWarningHighlight guibg=NONE guifg=#CCA700 gui=undercurl guisp=#CCA700 cterm=underline ctermfg=Yellow
hi CocInfoHighlight    guibg=NONE guifg=#CCA700 gui=undercurl guisp=#CCA700 cterm=underline ctermfg=Yellow
hi CocHintHighlight    guibg=NONE guifg=#CCA700 gui=undercurl guisp=#CCA700 cterm=underline ctermfg=Yellow
hi CocUnusedHighlight  guibg=NONE guifg=#6B6B6B gui=undercurl guisp=#6B6B6B cterm=underline ctermfg=Grey
hi CocDeprecatedHighlight guibg=NONE gui=strikethrough guisp=#6B6B6B cterm=strikethrough
hi CocErrorLine        guibg=NONE
hi CocWarningLine      guibg=NONE
