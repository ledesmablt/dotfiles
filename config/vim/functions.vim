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


""" one-liner commands
command Rest :e ~/.rest
command! Q mksession | q


""" mapping-related functions
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

function! SearchFiles()
  if len(gitbranch#dir(getcwd())) > 0
    GFiles
  else
    Files .
  endif
endfunction

function! ShowFileRelpath()
  let cwd = getcwd()
  let fpath = substitute(expand('%:p'), cwd . '/' , '', '')
  echo fpath
endfunction


""" command-related functions
" diff 2 windows
command! DiffThese :call <SID>diff_these()
function! s:diff_these()
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

" wipe matching buffers
command! -nargs=1 BW call <SID>wipe_matching_buffers('<args>')
function! s:wipe_matching_buffers(pattern)
  let bufferlist = filter(range(1,bufnr('$')), 'buflisted(v:val)')
  let matchlist = filter(bufferlist, 'bufname(v:val) =~ a:pattern')
  if len(matchlist) < 1
    echo 'No buffers found matching pattern ' . a:pattern
    return
  endif
  exec 'bw '.join(matchlist, ' ')
endfunction
