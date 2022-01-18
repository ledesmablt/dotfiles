""" sane defaults
syntax on
filetype plugin indent on
set number relativenumber
set smartindent autoindent smarttab expandtab
set nowrap
set cursorline
set incsearch
set nohls
set ignorecase smartcase

set noruler
set lazyredraw
set cmdheight=1
set laststatus=2
set noshowmode noshowcmd
" set colorcolumn=80
set updatetime=300

set path+=**
set wildmenu
set wildmode=longest:full,full

set hidden
set nofixeol
set autoread
set undodir=~/.vim/undodir
set undofile
set noswapfile
set noerrorbells


""" augroups
augroup SyntaxSettings
  autocmd!
  autocmd Filetype * setlocal ts=2 sw=2
  autocmd BufNewFile,BufRead *doc/*.txt setlocal ft=help ts=8 sw=8
  autocmd BufNewFile,BufRead *.tsx,*.jsx setlocal filetype=typescriptreact
  autocmd FileType python,markdown setlocal ts=4 sw=4
  autocmd FileType git set foldlevel=1
augroup END

augroup NvimTerm
    autocmd!
    " autocmd TermOpen * startinsert
    autocmd TermEnter * setlocal nonu nornu
    autocmd TermLeave * setlocal nu rnu
    " autocmd TermClose * call feedkeys("\<C-\>\<C-n>")
augroup END

augroup ReloadConfig
  autocmd!
  autocmd BufWritePost */nvim/lua/** source <afile> | PackerCompile
augroup END


" tmux display fix
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" imports
luafile ~/.config/nvim/lua/plugins.lua
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/functions.vim
source ~/.config/nvim/mappings.vim
if filereadable($HOME.'/.config/nvim/test-settings.vim')
  source ~/.config/nvim/test-settings.vim
endif
