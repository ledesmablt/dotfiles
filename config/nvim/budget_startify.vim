" Budget Startify
let g:sessionsave = getcwd().'/.session.vim'
let g:init_img = $HOME.'/.config/nvim/init_img.txt'
function! s:init()
  " init only if no args called
  if argc() || line2byte('$') != -1
    return
  end

  " center the thing
  let lines = readfile(g:init_img)
  let height = len(lines)
  let width = 1
  for line in lines
    if strwidth(line) > width
      let width = strwidth(line)
    end
  endfor

  " add top padding
  let winHeight = nvim_win_get_height(0)
  let nSpaceTop = float2nr((winHeight - height) / 2.5)
  for i in range(nSpaceTop)
    call append('$', '')
  endfor

  " prep left padding
  let winWidth = nvim_win_get_width(0)
  let nSpaceLeft = float2nr((winWidth - width) / 2)
  let leftPadding = ''
  for i in range(nSpaceLeft)
    let leftPadding = ' ' . leftPadding
  endfor

  " draw w/ left padding
  for line in lines
    call append('$', leftPadding . l:line)
  endfor

  setlocal colorcolumn=-1 nornu nonu noma bufhidden=wipe buftype=nowrite ft=myinitpage
endfunction

augroup BudgetStartify
  autocmd!
  autocmd VimEnter * call s:init()
augroup END
