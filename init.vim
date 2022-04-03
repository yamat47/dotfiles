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

if &compatible
  set nocompatible
endif

set runtimepath+=/Users/yamat47/.cache/dein/repos/github.com/Shougo/dein.vim

call dein#begin('/Users/yamat47/.cache/dein')
call dein#add('/Users/yamat47/.cache/dein/repos/github.com/Shougo/dein.vim')
call dein#load_toml('~/.config/nvim/plugins.toml', {'lazy': 0})
call dein#load_toml('~/.config/nvim/ddc.toml', {'lazy': 1})
call dein#load_toml('~/.config/nvim/ddu.toml', {'lazy': 1})
call dein#end()

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
