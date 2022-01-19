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
nnoremap <silent> - :NERDTreeFind<CR>
nnoremap <silent> _ :NERDTreeCWD<CR>
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

" utility
nnoremap <silent> <leader><C-l> :e<CR>:redraw<CR>
nnoremap <silent> <leader>td :VimwikiIndex<CR> :VimwikiGoto todo<CR>
nnoremap <silent> <leader>@ "0yiW:!xdg-open <C-R>0<CR>
vnoremap <silent> <leader>@ "0y:!xdg-open <C-R>0<CR>

" plugins
imap <silent> <C-l> <C-y>,
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
nnoremap <silent> <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>
nnoremap <silent> dga :diffget //2<CR>
nnoremap <silent> dgl :diffget //3<CR>
nnoremap <silent> [t :FloatermPrev<CR>
nnoremap <silent> ]t :FloatermNext<CR>

nnoremap <silent> <leader>gm :lua require('harpoon.mark').add_file(); require('harpoon.ui').toggle_quick_menu()<CR>
nnoremap <silent> <leader>m :lua require('harpoon.ui').toggle_quick_menu()<CR>

" search
nnoremap <silent> <leader>gf :Telescope git_files<CR>
nnoremap <silent> <leader>gg :Telescope git_status<CR>
nnoremap <silent> <leader>f :Telescope find_files<CR>
nnoremap <silent> <leader>/ :Telescope current_buffer_fuzzy_find<CR>
nnoremap <silent> <leader>? :Telescope keymaps<CR>
nnoremap <silent> <leader>b :Telescope buffers sort_mru=true<CR>
nnoremap <silent> <leader>ss :Telescope grep_string search=""<CR>
nnoremap <silent> <leader>sf :Telescope oldfiles<CR>
nnoremap <silent> <leader>sd :lua require('config.telescope').search_dotfiles()<CR>
nnoremap <silent> <leader>sh :lua require('config.telescope').command_history()<CR>

augroup Mappings
  autocmd!
  autocmd FileType nerdtree nnoremap <silent> <leader>u :NERDTreeClose<CR>:UndotreeToggle<CR>:UndotreeFocus<CR>
  autocmd FileType undotree nnoremap <silent> <leader>e :UndotreeHide<CR>:NERDTreeToggle<CR>
augroup END
