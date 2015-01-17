syntax on
set number

set nocompatible
set nohlsearch
set expandtab
set tabstop=2
set autoindent
set laststatus=2
set incsearch
set ignorecase
set backspace=indent,start,eol
set guifont=Migu_1M:h12

let g:indent = 2

nnoremap /  /\v
nnoremap ,U :se enc=utf-8<CR>
nnoremap ,S :se enc=Shift-JIS<CR>
nnoremap > :call Indent()<CR>
nnoremap < :call Unindent()<CR>

command! -complete=file -nargs=+ Grep call DoGrep(<f-args>)

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = { 
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'right': [ ['lineinfo'],
      \              ['parcent', "%"],
      \              ['fileformat'],
      \              ['fileencoding', 'filetype']]
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' },
      \ }
let g:markdown_fenced_languages = [
      \ 'java', 
      \ 'javascript', 
      \ 'php', 
      \ 'python', 
      \ 'perl', 
      \ 'ruby', 
      \ 'c', 
      \ 'cpp', 
      \ 'vim', 
      \ 'html', 
      \ 'css', 
      \ ]

augroup mysetting
  autocmd!
  autocmd BufNewFile,BufRead *.inc set filetype=php
  autocmd BufNewFile,BufRead *.jst set filetype=javascript
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufWrite * call DeleteBlankLineIndent()
augroup END

function! DeleteBlankLineIndent()
  let line = line(".")
  let col = col(".")
  %call DeleteBlankLineIndentSub()
  call cursor(line, col)
endfunction

function! DeleteBlankLineIndentSub()
  let line = getline(line("."))
  if line=~"^\\s\\+$"
    call setline(line("."), "")
  endif
endfunction

function! Indent()
  let l:indent = ""
  for i in range(1, g:indent)
    let l:indent = indent . " "
  endfor
  call setline(line("."), l:indent . getline(line(".")))
endfunction

function! Unindent()
  let l:s = getline(line("."))
  for i in range(1, g:indent)
    if l:s[0] =~ "\\s"
      let l:s = l:s[1:]
    else
      break
    endif
  endfor
  call setline(line("."), l:s)
endfunction

function! DoGrep(...)
  if len(a:000) == 1
    vimgrep a:1 % | cw
  elseif len(a:000) == 2
    vimgrep a:1 a:2 | cw
  endif
endfunction
