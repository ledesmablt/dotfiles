""" mappings
let mapleader = ' '

" filetype-specific
augroup FTMappings
  autocmd!
  autocmd Filetype man nnoremap <buffer> <silent> q :q<CR>
augroup END

" editing
nnoremap <silent> <leader>? :Maps<CR>
nnoremap <silent> <leader><Tab> <C-^>
nnoremap <silent> <leader>p :set paste!<CR>
nnoremap <silent> <leader>o i<CR><Esc>%a<CR>
nnoremap <silent> <leader>t oi<C-R>=
vnoremap <silent> <leader>p "_dp<CR>
vnoremap <silent> <leader>P "_dP<CR>

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
nnoremap <silent> <C-J> :cn<CR>
nnoremap <silent> <C-K> :cp<CR>

" utility
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
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :call SearchFiles()<CR>
nnoremap <silent> <leader>ss :Ag<CR>
nnoremap <silent> <leader>sf :History<CR>
nnoremap <silent> <leader>sh :History:<CR>
nnoremap <silent> <leader>sn :Snippets<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>
nnoremap <silent> <F4> :Nuake<CR>
inoremap <silent> <F4> <C-\><C-n>:Nuake<CR>
tnoremap <silent> <F4> <C-\><C-n>:Nuake<CR>
