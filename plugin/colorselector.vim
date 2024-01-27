" Colorselector plugin
" Version: 1.1
" Author : marsh
"

if exists('g:loaded_vim_colorselector')
  finish
endif
let g:loaded_vim_colorselector = 1

let s:save_cpo = &cpo
set cpo&vim

" plugin commands
"
command! -nargs=0  ColorSchemeOpen   :call colorselector#buffer_open()
command! -nargs=0  ColorSchemeClose  :call colorselector#buffer_close()
command! -nargs=0  ColorSchemeToggle :call colorselector#buffer_toggle()

let &cpo = s:save_cpo
unlet s:save_cpo
