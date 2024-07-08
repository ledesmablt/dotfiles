""" plugin imports
call plug#begin('~/.vim/plugged')
" menus
Plug 'vim-utils/vim-man', {'on': 'Man'}
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'ledesmablt/vim-run'
Plug 'junegunn/vim-peekaboo' " show registers during brain lag

" editing
Plug 'tpope/vim-abolish' " %S case-sensitive replacement
Plug 'tpope/vim-repeat' " repeat . commands for plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' " vscode-style commenting out
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " fugitive + GitHub
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-unimpaired' " ??? not sure if i use keybinds here yet
Plug 'unblevable/quick-scope' " highlight when pressing F in normal mode
" Plug 'SirVer/ultisnips'

" lang
Plug 'mattn/emmet-vim'

" aesthetics
Plug 'machakann/vim-highlightedyank'

call plug#end()


let g:highlightedyank_highlight_duration = 400
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:ft_man_no_sect_fallback = 1
let g:run_autosave_logs = 1
let g:run_quiet_default = 1
let g:run_nostream_default = 1
let g:peekaboo_delay = 900
" let g:UltiSnipsEnableSnipMate = 0
" let g:UltiSnipsEditSplit = 'horizontal'
" let g:UltiSnipsExpandTrigger="<c-j>"
