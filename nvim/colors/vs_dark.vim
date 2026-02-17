" Dark (Visual Studio) color scheme for Neovim
" Ported from vim/.vim/colors/vs_dark.vim

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
hi StatusLine   guifg=#D4D4D4 guibg=#2f2f2f
hi StatusLineNC guifg=#6B6B6B guibg=#2f2f2f
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

" =====================
" Window filler / zen-mode backdrop
" =====================
hi EndOfBuffer  guifg=#2f2f2f guibg=#2f2f2f
hi WinSeparator guifg=#2f2f2f guibg=#2f2f2f
hi NonText      guifg=#2f2f2f guibg=#2f2f2f
hi ZenBg        guifg=#2f2f2f guibg=#2f2f2f
hi SignColumn   guibg=#2f2f2f
hi FoldColumn   guibg=#2f2f2f

" =====================
" nvim-tree highlights
" =====================
hi Directory                 guifg=#87CFFF
hi NvimTreeFolderName        guifg=#569CD6 gui=bold
hi NvimTreeOpenedFolderName  guifg=#569CD6 gui=bold
hi NvimTreeRootFolder        guifg=#87CFFF gui=bold

" =====================
" Diagnostics (replaces CoC highlights)
" =====================
hi DiagnosticError          guifg=#F44747
hi DiagnosticWarn           guifg=#CCA700
hi DiagnosticInfo           guifg=#CCA700
hi DiagnosticHint           guifg=#CCA700
hi DiagnosticUnderlineError guibg=NONE gui=undercurl guisp=#F44747
hi DiagnosticUnderlineWarn  guibg=NONE gui=undercurl guisp=#CCA700
hi DiagnosticUnderlineInfo  guibg=NONE gui=undercurl guisp=#CCA700
hi DiagnosticUnderlineHint  guibg=NONE gui=undercurl guisp=#CCA700
hi DiagnosticUnnecessary    guifg=#6B6B6B gui=undercurl guisp=#6B6B6B
hi DiagnosticDeprecated     gui=strikethrough guisp=#6B6B6B
