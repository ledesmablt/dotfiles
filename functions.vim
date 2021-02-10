""" functions & abbrevs
" edit vimrc
let rcloc = '~/.config/vim/init.vim'
cnoreabbrev <silent> <expr> erc
      \ ((getcmdtype() is# ':' && getcmdline() is# 'erc')
      \ ? ('e '.rcloc) : 'erc')

" reload vimrc
cnoreabbrev <silent> <expr> rrc
      \ ((getcmdtype() is# ':' && getcmdline() is# 'rrc')
      \ ? ('source '.rcloc.' <Bar> call lightline#update()') : 'rrc')

" cd to buffer dir
cnoreabbrev <silent> <expr> cdf
      \ ((getcmdtype() is# ':' && getcmdline() is# 'cdf')
      \ ? ('cd %:p:h <Bar> pwd') : 'cdf')


" yank to windows clipboard
function! LeaderYW(is_entire_file)
  let clipfile = '/tmp/clip'
  if a:is_entire_file
    let yankedlines = getbufline('%', 1, '$')
  else
    let yankedlines = split(@0, "\n")
  endif
  call writefile(yankedlines, clipfile)
  call system('cat '.clipfile.' | clip.exe')
  messages clear 
  echo len(yankedlines).' lines yanked to clipboard'
endfunction

" diff 2 windows
function! DiffThese()
  if &diff
    diffoff!
  elseif winnr('$') != 2
    echohl WarningMsg | echo '2 windows must be open for diff' | echohl None
    return
  else
    let currentwin = winnr()
    let otherwin = currentwin == 2 ? 1 : 2
    diffthis
    exec otherwin.'wincmd w'
    diffthis
    exec currentwin.'wincmd w'
  endif
endfunction

" open rest default file 
command Rest :e ~/.rest
