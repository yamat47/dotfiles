augroup MyAutoCmd
  autocmd!
augroup END

"dein Scripts-----------------------------
if &compatible
  " Be iMproved
  set nocompatible
endif

" Required:
set runtimepath+=/home/admin/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/admin/.cache/dein')
  call dein#begin('/home/admin/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/admin/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:

  call dein#add('Shougo/deoplete.nvim')
  call dein#add('yamat47/vim-monokai-pro')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-git')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/defx.nvim')
  call dein#add('Shougo/deol.nvim')
  call dein#add('janko/vim-test')
  call dein#add('thinca/vim-zenspace')
  call dein#add('tpope/vim-commentary')
  call dein#add('junegunn/vim-easy-align')

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

"-- Shougo/deoplete.nvim ----------------------------
let g:deoplete#enable_at_startup = 1

"-- tpope/vim-git ----------------------------
let g:gitcommit_cleanup = "scissors"

"-- yamat47/vim-monokai-pro ----------------------------
let g:monokai_pro#background = "transparent"
colorscheme monokai_pro
set termguicolors

"-- Shougo/denite.nvim ----------------------------
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q       denite#do_map('quit')
  nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

" Change file/rec command.
call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Ag command on grep source
call denite#custom#var('grep', 'command',        ['ag'])
call denite#custom#var('grep', 'default_opts',   ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt',    [])
call denite#custom#var('grep', 'separator',      ['--'])
call denite#custom#var('grep', 'final_opts',     [])

" Change ignore_globs
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [ '.git/', '*.css' ])

" Key mapping
nmap <silent> <C-d><C-g> :<C-u>Denite grep -split=floating<CR>
nmap <silent> <C-d><C-]> :<C-u>DeniteCursorWord grep -split=floating<CR>
nmap <silent> <C-d><C-l> :<C-u>Denite file/rec -split=floating file:new<CR>
nmap <silent> <C-d><C-r> :<C-u>Denite -resume<CR>
nmap <silent> <C-d><C-n> :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nmap <silent> <C-d><C-p> :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>

augroup transparent-windows
  autocmd!
  autocmd FileType denite set winblend=50
  autocmd FileType denite-filter set winblend=50
augroup END


"-- Shougo/defx.nvim -------------------------------------
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
  nnoremap <silent><buffer><expr> c defx#do_action('copy')
  nnoremap <silent><buffer><expr> m defx#do_action('move')
  nnoremap <silent><buffer><expr> p defx#do_action('paste')
  nnoremap <silent><buffer><expr> l defx#do_action('open')
  nnoremap <silent><buffer><expr> E defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d defx#do_action('remove')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ; defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
endfunction

" Show ignored files
call defx#custom#option('_', {'show_ignored_files': 1})

" Key mapping
nmap <silent> <C-d><C-f> :<C-u>Defx<CR>

"-- janko/vim-test -------------------------------------
let test#strategy = 'neovim'

let test#ruby#rspec#executable = 'spec'
let test#javascript#ava#executable = 'yarn test'

nmap <silent> <C-t><C-n> :TestNearest<CR>
nmap <silent> <C-t><C-f> :TestFile<CR>
nmap <silent> <C-t><C-s> :TestSuite<CR>
nmap <silent> <C-t><C-l> :TestLast<CR>
nmap <silent> <C-t><C-g> :TestVisit<CR>

"-- junegunn/vim-easy-align -----------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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

let g:python_host_prog  = '/home/linuxbrew/.linuxbrew/bin/python'
let g:python3_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3'
