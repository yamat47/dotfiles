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
set list

set showmode
set showcmd
set ambiwidth=double

command! Pbcopy :%w !pbcopy

tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <silent> <ESC><ESC> :nohlsearch <CR>
nnoremap <silent> <C-n><C-n> :set invnumber<CR>

set termguicolors
