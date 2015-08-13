syntax on
set number

set nocompatible
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set laststatus=2
set incsearch
set ignorecase
set backspace=indent,start,eol
set guifont="Migu 1M 12"
set wrap
set textwidth=0
set colorcolumn=80
set nohlsearch
set mouse=a

if !has('gui_running')
  set visualbell
  set t_vb=
  set t_Co=256
endif

colorscheme hybrid

let g:indent = 2
"---------------------------
"" Start Neobundle Settings.
"---------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Yggdroot/indentLine'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'lervag/vim-latex'
"NeoBundle 'Rip-Rip/clang_complete'

call neobundle#end()
filetype plugin indent on

NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

let g:jedi#auto_initialization = 1
let g:jedi#completions_command = "<C-n>"

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:clang_use_library = 1

let g:clang_library_path = '/usr/share/clang/'
let g:clang_debug = 1
let g:clang_user_options = '-std=c++11 -stdlib=libc++'

let g:indentLine_char='|'

let g:syntastic_mode_map = { 'mode': 'passive' }
let g:tex_conceal=''
let g:latex_latexmk_continuous = 1

nnoremap /  /\v
nnoremap ,U :se enc=utf-8<CR>
nnoremap ,S :se enc=Shift-JIS<CR>
nnoremap .U :e ++enc=utf-8<CR>
nnoremap .S :e ++enc=Shift-JIS<CR>
nnoremap zs zA
nnoremap <C-d> <C-b>
nnoremap <silent> > :call Indent()<CR>
nnoremap <silent> < :call Unindent()<CR>
inoremap <C-v> <ESC>"+gPi<right>
nnoremap <C-v> "+gP<right>
nnoremap <silent> <Leader>g :SearchWord expand("<cword>")<CR>
nnoremap <silent> <Leader>a :SearchWordAll expand("<cword>")<CR>
command! -nargs=1 SearchWord bufdo vimgrepa <args> % | cw
command! -nargs=1 SearchWordAll vimgrep <args> * | cw
nmap <F8> :TagbarToggle<CR>

let g:lightline = { 
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'right': [ ['syntastic', 'lineinfo'],
      \              ['percent'],
      \              ['fileformat'],
      \              ['fileencoding', 'filetype']]
      \ },
      \ 'component_expand': {
      \  'syntastic': 'SyntasticStatuslineFlag', 
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Autocmd                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup mysetting
  autocmd!
  autocmd BufNewFile,BufRead *.inc set filetype=php
  autocmd BufNewFile,BufRead *.jst set filetype=javascript
  autocmd BufNewFile,BufRead *.sage set filetype=python
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufWrite * call DeleteBlankLineIndent()
  autocmd BufWritePost * call s:syntastic()
  autocmd FileType python setlocal completeopt-=preview
  autocmd FileType c,cpp setlocal foldmethod=syntax
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Functions                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
