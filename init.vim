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
set colorcolumn=80
set updatetime=300

set path+=**
set wildmenu
set wildmode=longest:full,full

set hidden
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
augroup END


""" abbrevs
cnoreabbrev <silent> <expr> erc 
      \ ((getcmdtype() is# ':' && getcmdline() is# 'erc')
      \ ? ('e ~/.config/vim/init.vim') : 'erc')
cnoreabbrev <silent> <expr> rrc 
      \ ((getcmdtype() is# ':' && getcmdline() is# 'rrc')
      \ ? ('source '.$MYVIMRC.' <Bar> call lightline#update()') : 'rrc')

" tmux display fix
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" imports
source ~/.config/vim/plugins.vim
source ~/.config/vim/coc.vim
source ~/.config/vim/functions.vim
source ~/.config/vim/mappings.vim
if !empty(glob('~/.config/vim/test-settings.vim'))
  source ~/.config/vim/test-settings.vim
endif
