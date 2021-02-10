""" plugin imports
call plug#begin('~/.vim/plugged')
" menus
Plug 'vimwiki/vimwiki'
Plug 'vim-utils/vim-man', {'on': 'Man'}
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'preservim/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'ledesmablt/vim-run'

" functional
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'unblevable/quick-scope'
Plug 'diepm/vim-rest-console'

" lang
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'typescriptreact']}
Plug 'peitalin/vim-jsx-typescript', {'for': 'typescriptreact'}
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" aesthetics
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'wadackel/vim-dogrun'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/edge'

" test
call plug#end()


""" plugin settings
" theme
colo dogrun
let g:lightline = {'colorscheme': 'dogrun'}

" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '--reverse'
if v:version >= 802
  let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
endif

" ripgrep
let g:rg_derive_root = 'true'
let g:ctrlp_user_command = ['.git/',
      \ 'git --git-dir=%s/.git ls-files -oc --exclude-standard'
      \ ]

" vimwiki
let g:vimwiki_list = [{
      \ 'path': '~/.vim/wiki/raw', 'path_html': '~/.vim/wiki/html',
      \ 'syntax': 'markdown', 'ext': '.md'}
      \ ]

" other
let g:highlightedyank_highlight_duration = 400
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:ft_man_no_sect_fallback = 1
let g:run_autosave_logs = 1
let g:run_quiet_default = 1
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_curl_opts = {'-s': ''}
if has('nvim')
  let g:run_nostream_default = 1
endif
