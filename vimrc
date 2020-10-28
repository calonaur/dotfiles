" calonaur's ~/.vimrc
"
" designed for vim 8.0+ (or neovim) and tmux

" defaults
let skip_defaults_vim=1
set nocompatible
" get backspace to work on macOS
set backspace=indent,eol,start
filetype on

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
" search as you type
set incsearch
" don't pass short messages
set shortmess+=c
" swapfiles are annoying
set noswapfile

" command history
set history=100
" persistent undo
if has('persistent_undo')
  " create dirs
  silent !mkdir -p $HOME/.vim/
  silent !mkdir -p $HOME/.vim/undodir
  set undodir=$HOME/.vim/undodir
  set undofile
  
  silent !mkdir -p $HOME/.vim/backup
  set backupdir=$HOME/.vim/backup
  set backup
  set writebackup
  set backupcopy=yes
endif

" colours
syntax enable
" faster scrolling
set ttyfast
" inside voice
set noerrorbells
" enable 24-bit colour
set termguicolors
" reminder of the last line
set wrap
set linebreak
set textwidth=79
set colorcolumn=79
highlight ColorColumn ctermbg=0


"" remaps & autocommands
let mapleader = " "
if has("autocmd")

  " jump to last position
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " sensible backup names
  au BufWritePre * let &bex = '@' . strftime("%F_%H:%M")

  " keep cursor centered ("typewriter mode")
  augroup VCenterCursor
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.*
      \ let &scrolloff=winheight(win_getid())/2
  augroup END

  " soft wrap at 79
  au VimResized * if (&columns > 79) | set columns=79 | endif

  " buffer syntax types
  au bufnewfile,bufRead *bash* set ft=sh
endif

"" Plugins

if empty(glob("$HOME/.vim/autoload/plug.vim"))
  silent !curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter & PlugInstall 
endif

if filereadable(expand("$HOME/.vim/autoload/plug.vim"))
  call plug#begin("$HOME/.vim/plugged")

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'flazz/vim-colorschemes'
  Plug 'sheerun/vim-polyglot'
  Plug 'lervag/wiki.vim'
  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
  endif

endif
