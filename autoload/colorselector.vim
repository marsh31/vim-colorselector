" Colorselector autoload
" Version: 1.1
" Author : marsh

let s:buffer_name   = "colorselector"

let s:buffer_opener = "vsplit"
" let s:buffer_opener = "split"

let s:buffer_side   = "leftabove"
" let s:buffer_side   = "rightbelow"

"
" IF
"
function! colorselector#buffer_open()
  augroup plugin_colorlist_file_init
    autocmd! * <buffer>
    execute "autocmd FileType " .. s:buffer_name .. " call s:init()"
  augroup END

  let bufferlines = s:get_color_schemes()
  let buffercolmaxsize = max(map(copy(bufferlines), 'strlen(v:val)')) + 10

  noautocmd hide execute s:buffer_side .. " " .. buffercolmaxsize .. s:buffer_opener .. " " .. s:buffer_name

  execute  "setlocal ft=" .. s:buffer_name
  setlocal buftype=acwrite bufhidden=wipe noswapfile
  setlocal nonumber norelativenumber
  setlocal conceallevel=3 concealcursor=nvic


  call append('$', bufferlines)
  :g/^$/delete_

  augroup plugin_colorlist_file
    autocmd! * <buffer>
    autocmd CursorMoved <buffer> nested call s:buffer_change_colorscheme()

    autocmd BufWriteCmd <buffer> nested call s:apply()
    autocmd BufWipeout  <buffer> nested call s:wipeout()
  augroup END

  setlocal nomodified nomodifiable readonly
endfunction


function! colorselector#buffer_close()
  echo "Not Implemented"
endfunction


function! colorselector#buffer_toggle()
  echo "Not Implemented"
endfunction



"
" SCRIPT LOCAL
"
function! s:get_color_schemes()
  return uniq(sort(map(
        \ globpath(&runtimepath, "colors/*.vim", 0, 1),
        \ 'fnamemodify(v:val, ":t:r")'
        \ )))
endfunction


function! s:get_cmd_color_scheme()
  return "colorscheme " .. getline('.')
endfunction


function! s:init() abort
  command! -buffer -nargs=0  ColorChange     :call s:buffer_change_colorscheme()
  command! -buffer -nargs=0  ColorYank       :call s:buffer_yank_colorscheme()
  command! -buffer -nargs=0  ColorMoveK      :call s:buffer_move_top()
  command! -buffer -nargs=0  ColorMoveJ      :call s:buffer_move_down()

  nmap <buffer><silent> <CR> :ColorChange<CR>
  nmap <buffer><silent> q    :q!<CR>
  nmap <buffer><silent> yy   :ColorYank<CR>

  nmap <buffer><silent> j    :ColorMoveJ<CR>
  nmap <buffer><silent> k    :ColorMoveK<CR>
endfunction


function! s:apply() abort
  " TODO: if needed, add it.
  setlocal nomodified
endfunction


function! s:wipeout() abort
  " TODO: if needed, add it.
endfunction



"
" ACTION LIST
"
function s:buffer_change_colorscheme()
  execute s:get_cmd_color_scheme()
endfunction


function s:buffer_yank_colorscheme()
  let @+ = s:get_cmd_color_scheme()
endfunction


function! s:buffer_move_top()
  let lnum = line('.')
  let buffer_min = 1

  if lnum == buffer_min
    normal! G
  else
    normal! k
  endif
endfunction


function! s:buffer_move_down()
  let lnum = line('.')
  let buffer_max = line('$')

  if lnum == buffer_max
    normal! gg
  else
    normal! j
  endif
endfunction
