augroup MyAutoCmd
  autocmd!
augroup END

"dein Scripts-----------------------------
if &compatible
  " Be iMproved
  set nocompatible
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " load plugins
  call dein#load_toml('~/.config/nvim/plugins.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/lazy_plugins.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"-- pure neovim configuration ----------------------------
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

highlight visual ctermbg=gray

command! Pbcopy :%w !pbcopy

tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <silent> <ESC><ESC> :nohlsearch <CR>
nnoremap <silent> <C-n><C-n> :set invnumber<CR>
