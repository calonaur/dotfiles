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
set ignorecase
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

  " UK Spelling for markdown
  autocmd FileType markdown setlocal spell spelllang=en_gb
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
  Plug 'lervag/wiki.vim'
  Plug 'flazz/vim-colorschemes'
  Plug 'sheerun/vim-polyglot'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'mbbill/undotree'
  Plug 'tpope/vim-commentary'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'vim-pandoc/vim-pandoc-after'
  Plug 'KeitaNakamura/tex-conceal.vim'

  if has('nvim')
    "Plug 'neovim/nvim-lspconfig' # TODO: uncomment this when 0.5 is released
  endif
  call plug#end()

  " junegunn/fzf
  nmap <leader>pt :Rg <C-R>=("TODO")<CR><CR>
  nmap <leader>po :GFiles<CR>
  nmap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
  nmap <leader>ps :Rg<SPACE>

  " lervag/wiki.vim
  let g:wiki_root = '~/Dropbox/notes/'
  let g:wiki_filetypes = ['md']
  let g:wiki_link_extension = '.md'
  let g:wiki_link_target_type = 'md'
  let g:wiki_write_on_nav = 1

  function WikiCreateMap(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
  endfunction

  let g:wiki_map_create_page = 'WikiCreateMap'
  let g:wiki_map_link_create = 'WikiCreateMap'

  nmap <leader>wl <plug>(wiki-journal-next)
  nmap <leader>wh <plug>(wiki-journal-prev)
  nmap <leader>wo <plug>(wiki-fzf-pages)
  nmap <leader>wk <plug>(wiki-journal-toweek)
  nmap <leader>wm <plug>(wiki-journal-tomonth)
  nmap <leader>wd <plug>(wiki-page-delete)

  " flazz/vim-colorschemes
  colorscheme gruvbox

  " tpope/vim-fugitive
  nmap <leader>gs :G<CR>
  nmap <leader>gn :diffget //3<CR>
  nmap <leader>gt :diffget //2<CR>

  " mbbill/undotree
  nmap <leader>u :UndotreeShow<CR>

  " vim-pandoc/vim-pandoc-syntax
  let g:pandoc#syntax#conceal#urls = 1
  let g:pandoc#modules#disabled = ["folding"]
  let g:pandoc#formatting#mode = 'ha'
  let g:pandoc_biblio_bibs = ["$HOME/Dropbox/notes/bibs/phd.md"]

  nmap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
  nmap <leader>f :resize 100<CR>






endif
