""" plugin imports
call plug#begin('~/.vim/plugged')
" menus
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'ledesmablt/vim-run'
Plug 'junegunn/vim-peekaboo'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'

" editing
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-rails'
Plug 'unblevable/quick-scope'
Plug 'SirVer/ultisnips'

" aesthetics

call plug#end()


let g:NERDTreeWinSize = 30
let g:undotree_SplitWidth = g:NERDTreeWinSize
let g:highlightedyank_highlight_duration = 400
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:ft_man_no_sect_fallback = 1
let g:run_autosave_logs = 1
let g:run_quiet_default = 1
let g:run_nostream_default = 1
let g:peekaboo_delay = 900
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsExpandTrigger="<c-j>"
