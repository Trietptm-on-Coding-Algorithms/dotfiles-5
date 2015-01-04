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
  let indent = ""
  for i in range(1, g:indent)
    let indent = indent . " "
  endfor
  call setline(line("."), indent . getline(line(".")))
endfunction

function! Unindent()
  call setline(line("."), getline(line("."))[g:indent :])
endfunction

function! ListBuffer()
  let l:line = 1
  for x in range(1,10)
    if buffer_exists(x)
      let name=split(buffer_name(x), "\\")
      if len(name) != 0
        call setline(line, name[len(name)-1])
        let l:line += 1
      endif
    endif
  endfor
endfunction

