""" sane defaults ------------------------------------------------------------
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
set laststatus=0
set noshowmode noshowcmd
set colorcolumn=80
set updatetime=300

set path+=**
set wildmenu
set wildmode=longest:full,full

set hidden
set undodir=~/.vim/undodir
set undofile
set noswapfile
set noerrorbells


""" augroups -----------------------------------------------------------------
augroup SyntaxSettings
  autocmd!
  autocmd Filetype * setlocal ts=2 sw=2
  autocmd BufNewFile,BufRead *doc/*.txt setlocal ft=help ts=8 sw=8
  autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript
  autocmd FileType python,markdown setlocal ts=4 sw=4
augroup END


""" abbrevs ------------------------------------------------------------------
cnoreabbrev <silent> <expr> erc 
      \ ((getcmdtype() is# ':' && getcmdline() is# 'erc')
      \ ? ('e ~/.vim/init.vim') : 'erc')
cnoreabbrev <silent> <expr> rrc 
      \ ((getcmdtype() is# ':' && getcmdline() is# 'rrc')
      \ ? ('source ~/.vim/init.vim <Bar> AirlineToggle <Bar> AirlineToggle') : 'rrc')


" imports
source ~/.vim/config/plugins.vim
source ~/.vim/config/coc.vim
source ~/.vim/config/functions.vim
source ~/.vim/config/mappings.vim
source ~/.vim/config/display.vim
if !empty(glob('~/.vim/config/test-settings.vim'))
  source ~/.vim/config/test-settings.vim
endif
