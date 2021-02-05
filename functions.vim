""" functions
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

function! s:getrc()
  let gistid = '8a14ed0126e77a6ef392e53c148d66c2'
  exec 'Gist '.gistid
endfunction
command GetRC :call s:getrc()
command Rest :e ~/.rest

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
