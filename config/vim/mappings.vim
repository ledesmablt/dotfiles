""" mappings
let mapleader = ' '

" filetype-specific
augroup FTMappings
  autocmd!
  autocmd Filetype man nnoremap <buffer> <silent> q :q<CR>
  autocmd Filetype vimwiki vnoremap <buffer> <silent> <leader>l <ESC>`<i[<ESC>`>la]()<ESC>"*P0`<
augroup END

" editing
nnoremap <silent> <leader><Tab> <C-^>
nnoremap <silent> <leader>p :set paste!<CR>
nnoremap <silent> <leader>o i<CR><Esc>%a<CR>
nnoremap <silent> <leader>t oi<C-R>=
vnoremap <silent> <leader>p "_dp<CR>
vnoremap <silent> <leader>P "_dP<CR>
nnoremap Y y$
inoremap <silent> ( ()<ESC>i
inoremap <silent> { {}<ESC>i
inoremap <silent> [ []<ESC>i
inoremap <silent> <M-h> <C-o>h
inoremap <silent> <M-l> <C-o>l
inoremap <silent> <M-w> <C-o>w
inoremap <silent> <M-b> <C-o>b
inoremap <silent> <M-W> <C-o>W
inoremap <silent> <M-B> <C-o>B

" navigation
" add to jumplist if jumping > 5 lines
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" windows
nnoremap <silent> <leader>h :wincmd h<CR>
nnoremap <silent> <leader>j :wincmd j<CR>
nnoremap <silent> <leader>k :wincmd k<CR>
nnoremap <silent> <leader>l :wincmd l<CR>
nnoremap <silent> <leader>H :vnew<CR>
nnoremap <silent> <leader>J :below new<CR>
nnoremap <silent> <leader>K :new<CR>
nnoremap <silent> <leader>L :below vnew<CR>
nnoremap <silent> <M-[> :resize -2<CR>
nnoremap <silent> <M-]> :resize +2<CR>
if has('nvim')
  tnoremap <silent> <C-W> <C-\><C-N><C-W>
endif
nnoremap <silent> <C-j> :cn<CR>
nnoremap <silent> <C-k> :cp<CR>
nnoremap <silent> <M-j> :cnewer<CR>
nnoremap <silent> <M-k> :colder<CR>

" utility
nnoremap <silent> <leader><C-l> :e<CR>:redraw<CR>
nnoremap <silent> <leader>td :VimwikiIndex<CR> :VimwikiGoto todo<CR>
nnoremap <silent> <leader>@ "0yiW:!xdg-open <C-R>0<CR>
vnoremap <silent> <leader>@ "0y:!xdg-open <C-R>0<CR>
if has('nvim')
  nnoremap <silent> <leader>yw :%y*<CR>
  vnoremap <silent> <leader>yw "*y
elseif $PATH =~ '/mnt/c/Windows'
  nnoremap <silent> <leader>yw :call LeaderYW(1)<CR>
  vnoremap <silent> <leader>yw "0y:call LeaderYW(0)<CR>
endif
nnoremap <silent> <leader>dt :call DiffThese()<CR>
nnoremap <silent> <leader>n :call ShowFileRelpath()<CR>

" plugins
imap <silent> <C-l> <C-y>,
nnoremap <silent> <leader>e :NERDTreeToggle<CR>

if has('nvim')
  " git
  nnoremap <silent> <leader>gf :Telescope git_files<CR>
  nnoremap <silent> <leader>gb :Telescope git_branches<CR>
  nnoremap <silent> <leader>gg :Telescope git_status<CR>

  " files
  nnoremap <silent> <leader>f :Telescope find_files<CR>
  " nnoremap <silent> <leader>ss :Telescope live_grep<CR>
  nnoremap <silent> <leader>/ :Telescope current_buffer_fuzzy_find<CR>
  nnoremap <silent> <leader>sd :lua require('config.telescope').search_dotfiles()<CR>

  " etc
  nnoremap <silent> <leader>sw :Telescope tmux windows<CR>
  nnoremap <silent> <leader>sh :Telescope command_history<CR>
  " nnoremap <silent> <leader>sr :Telescope registers<CR>
  nnoremap <silent> <leader>? :Telescope keymaps<CR>
  nnoremap <silent> <leader>m :Telescope marks<CR>

  " inoremap <silent> <C-a> <C-O>Telescope registers<CR>

else
  " fzf
  " nnoremap <silent> <leader>f :Files .<CR>
  nnoremap <silent> <leader>gf :GitFiles<CR>
  nnoremap <silent> <leader>m :Marks<CR>
  nnoremap <silent> <leader>sh :History:<CR>
  nnoremap <silent> <leader>? :Maps<CR>
endif
nnoremap <silent> <leader>sn :Snippets<CR>
nnoremap <silent> <leader>sf :History<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>ss :Ag<CR>

nnoremap <silent> <leader>c :Commentary<CR>
vnoremap <silent> <leader>c :Commentary<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>
nnoremap <silent> <F4> :Nuake<CR>
inoremap <silent> <F4> <C-\><C-n>:Nuake<CR>
tnoremap <silent> <F4> <C-\><C-n>:Nuake<CR>
nnoremap <silent> dga :diffget //2<CR>
nnoremap <silent> dgl :diffget //3<CR>

augroup Mappings
  autocmd!
  autocmd FileType nerdtree nnoremap <silent> <leader>u :NERDTreeClose<CR>:UndotreeToggle<CR>:UndotreeFocus<CR>
  autocmd FileType undotree nnoremap <silent> <leader>e :UndotreeHide<CR>:NERDTreeToggle<CR>
augroup END
