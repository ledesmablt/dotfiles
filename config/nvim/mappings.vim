""" mappings
let mapleader = ' '

" editing
nnoremap <silent> <leader><Tab> <C-^>
nnoremap <silent> <leader>o i<CR><Esc>%a<CR>
nnoremap <silent> <leader>t oi<C-R>=
vnoremap <silent> <leader>p "_dp<CR>
vnoremap <silent> <leader>P "_dP<CR>
nnoremap Y y$
inoremap <silent> <M-h> <C-o>h
inoremap <silent> <M-l> <C-o>l
inoremap <silent> <M-w> <C-o>w
inoremap <silent> <M-b> <C-o>b
inoremap <silent> <M-W> <C-o>W
inoremap <silent> <M-B> <C-o>B

" select in / around "/"
nnoremap <silent> vi/ T/vt/
nnoremap <silent> va/ F/vf/

" start %s on current / highlighted word
nnoremap <silent> <C-s> :%s/\<<C-r><C-w>\>/
vnoremap <silent> <C-s> "0y:%s/\<<C-r>0\>/

" note: C-_ is actually C-/
nnoremap <silent> <C-_> :Commentary<CR>
vnoremap <silent> <C-_> :Commentary<CR>

" navigation
" add to jumplist if jumping > 5 lines
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <silent> - :CHADopen --always-focus<CR>
nnoremap <silent> + :FloatermNew<CR>

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
tnoremap <silent> <C-W> <C-\><C-N><C-W>
nnoremap <silent> <C-j> :cn<CR>
nnoremap <silent> <C-k> :cp<CR>
nnoremap <silent> <M-j> :cnewer<CR>
nnoremap <silent> <M-k> :colder<CR>

" reset the screen
nnoremap <silent> <leader><C-l> :e<CR>:redraw<CR>:set nu rnu<CR>

" plugins
imap <silent> <C-l> <C-y>,
nnoremap <silent> <leader>e :CHADopen<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>
nnoremap <silent> dga :diffget //2<CR>
nnoremap <silent> dgl :diffget //3<CR>
nnoremap <silent> [t :FloatermPrev<CR>
nnoremap <silent> ]t :FloatermNext<CR>

" search
nnoremap <silent> <leader>gf :Telescope git_files<CR>
nnoremap <silent> <leader>gg :Telescope git_status<CR>
nnoremap <silent> <leader>f :Telescope find_files<CR>
nnoremap <silent> <leader>/ :Telescope current_buffer_fuzzy_find<CR>
nnoremap <silent> <leader>? :Telescope keymaps<CR>
nnoremap <silent> <leader>b :Telescope buffers sort_mru=true ignore_current_buffer=true<CR>
nnoremap <silent> <leader>ss :Telescope grep_string search=""<CR>
nnoremap <silent> <leader>sg :Telescope live_grep<CR>
nnoremap <silent> <leader>sq :Telescope quickfix<CR>
nnoremap <silent> <leader>sf :Telescope oldfiles<CR>
nnoremap <silent> <leader>sd :lua require('config.telescope').search_dotfiles()<CR>
nnoremap <silent> <leader>sh :lua require('config.telescope').command_history()<CR>
