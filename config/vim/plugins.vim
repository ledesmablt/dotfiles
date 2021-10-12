""" plugin imports
call plug#begin('~/.vim/plugged')
" menus
Plug 'vimwiki/vimwiki'
Plug 'vim-utils/vim-man', {'on': 'Man'}
Plug 'jremmen/vim-ripgrep', {'on': 'Rg'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'preservim/nerdtree'
Plug 'ledesmablt/vim-run'
Plug 'junegunn/vim-peekaboo'
Plug 'diepm/vim-rest-console', {'for': 'rest'}
Plug 'Lenovsky/nuake', {'on': 'Nuake'}
Plug 'dbeniamine/cheat.sh-vim', {'on': 'HowIn'}

" editing
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'unblevable/quick-scope'
Plug 'SirVer/ultisnips'

" lang
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim', {'for': ['typescript', 'typescriptreact']}
Plug 'peitalin/vim-jsx-typescript', {'for': 'typescriptreact'}
Plug 'jparise/vim-graphql', {'for': 'graphql'}
Plug 'mattn/emmet-vim'
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'pantharshit00/vim-prisma'

" aesthetics
Plug 'junegunn/goyo.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'ap/vim-css-color'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'wadackel/vim-dogrun'
Plug 'embark-theme/vim'

call plug#end()


""" plugin settings
" theme
colo dogrun
let g:lightline = {'colorscheme': 'dogrun',
      \ 'active': {
      \   'left': [
      \       ['mode', 'paste'],
      \       ['readonly', 'filename', 'modified']
      \   ],
      \   'right': [
      \       [], ['filetype'], ['gitbranch']
      \   ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ }}

" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_OPTS = '--reverse --bind ctrl-a:select-all'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9 } }
let g:fzf_preview_window = ['down:40%', 'ctrl-/']

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
let g:NERDTreeWinSize = 30
let g:undotree_SplitWidth = g:NERDTreeWinSize
let g:highlightedyank_highlight_duration = 400
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:ft_man_no_sect_fallback = 1
let g:run_autosave_logs = 1
let g:run_quiet_default = 1
let g:run_nostream_default = 1
let g:vrc_response_default_content_type = 'application/json'
let g:vrc_curl_opts = {'-s': ''}
let g:peekaboo_delay = 1200
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsExpandTrigger="<c-j>"
