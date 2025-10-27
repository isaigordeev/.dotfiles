" Visual Studio Light theme for Vim
" Author: converted from VS Code Light (Visual Studio)
" Usage: save as ~/.vim/colors/vslight.vim and :colorscheme vslight

set background=light
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "vslight"

" Editor colors
hi Normal        guifg=#000000 guibg=#FFFFFF
hi CursorLine    guibg=#E5EBF1
hi Visual        guibg=#ADD6FF
hi LineNr        guifg=#6F6F6F guibg=#FFFFFF
hi Comment       guifg=#008000 gui=italic
hi Constant      guifg=#0000ff
hi String        guifg=#a31515
hi Number        guifg=#098658
hi Boolean       guifg=#098658
hi Identifier    guifg=#0000ff
hi Function      guifg=#0000ff
hi Statement     guifg=#0000ff
hi Conditional   guifg=#0000ff
hi Repeat        guifg=#0000ff
hi Operator      guifg=#000000
hi Keyword       guifg=#0000ff
hi Type          guifg=#0000ff
hi PreProc       guifg=#0000ff
hi Special       guifg=#0451a5
hi Underlined    gui=underline guifg=#000080
hi Error         guifg=#cd3131 guibg=#FFFFFF
hi Todo          guifg=#800000 gui=bold

" UI elements
hi StatusLine        guifg=#000000 guibg=#F3F3F3
hi StatusLineNC      guifg=#6F6F6F guibg=#F3F3F3
hi Pmenu             guifg=#000000 guibg=#F3F3F3
hi PmenuSel          guifg=#000000 guibg=#ADD6FF
hi VertSplit         guifg=#D4D4D4
hi TabLine           guifg=#6F6F6F guibg=#F3F3F3
hi TabLineSel        guifg=#333333 guibg=#FFFFFF gui=bold
hi VisualNOS         guibg=#E5EBF1

" Diff colors
hi DiffAdd           guifg=#098658 guibg=#f8f8f8
hi DiffChange        guifg=#0451a5 guibg=#f8f8f8
hi DiffDelete        guifg=#a31515 guibg=#f8f8f8
hi DiffText          guifg=#FFFFFF guibg=#007ACC

