" Vim color file
"
" Focus on a single line.

hi clear

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax off
    endif
endif

let g:colors_name="invis"

hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D

hi Normal          guifg=#272822 guibg=#272822
hi CursorLine      guifg=#3E3D32  guibg=#3E3D32
hi CursorColumn    guifg=#3E3D32  guibg=#3E3D32
hi LineNr          guifg=#BCBCBC guibg=#3B3A32
hi NonText         guifg=#BCBCBC guibg=#3B3A32

"
" Support for 256-color terminal
"
if &t_Co > 255

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi Normal          ctermfg=233  ctermbg=233
   hi CursorLine      ctermfg=234 ctermbg=234   cterm=none
   hi CursorColumn     ctermfg=234 ctermbg=234
   hi LineNr          ctermfg=250 ctermbg=234
   hi NonText         ctermfg=250 ctermbg=234
end
