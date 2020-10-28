" calonaur's ~/.vimrc
"
" designed for vim 8.0+ (or neovim) and tmux

" defaults
let skip_defaults_vim=1
set nocompatible
" get backspace to work on macOS
set backspace=indent,eol,start

" indent newlines
set autoindent
set smartindent
" write files when changing buffer
set autowrite
" insert spaces instead of tabs
set softtabstop=2
set shiftwidth=2
set smarttab
" avoid 'hit enter to...' messages
set shortmess=aoOtI
" prevent truncated yanks / deletes
set viminfo='20,<1000,s1000
" disable automatic folding
set foldmethod=manual
"set conceallevel=2
" don't complain about switching buffer with changes
set hidden
" command history
set history=100
" persistent undo
if has('persistent_undo')
  " create dirs
  :silent call system('mkdir ' . '$HOME/.vim/')
  :silent call system('mkdir ' . '$HOME/.vim/undodir')
  set undodir=$HOME/.vim/undodir
  set undofile
endif

" colours
syntax enable
" faster scrolling
set ttyfast
" inside voice
set noerrorbells


