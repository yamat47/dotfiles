augroup MyAutoCmd
  autocmd!
augroup END

let $CACHE  = expand('$HOME/.cache')
let $CONFIG = expand('$HOME/.config')

function! s:load(file) abort
  let s:path = expand('$CONFIG/nvim/rc/' . a:file . '.vim')

  if filereadable(s:path)
    execute 'source' fnameescape(s:path)
  endif
endfunction

call s:load('plugins')

set whichwrap=b,s,h,l,>,[,]
set matchpairs=(:),{:},[:],<:>

set hlsearch
set ignorecase
set wildmenu
set incsearch

set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set backspace=1
set backspace=start,eol,indent

set showmode
set showcmd
set ambiwidth=double

highlight visual ctermbg=gray

command! Pbcopy :%w !pbcopy

tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <ESC><ESC> :nohlsearch <CR>
nnoremap <C-N><C-N> :set invnumber<CR>
nnoremap ,r :source ~/.config/nvim/init.vim<cr>

let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog  = '/usr/local/bin/python3'

let &shell='/bin/bash --login'
