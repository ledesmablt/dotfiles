""" functions
""" one-liner commands
command! ERC :exec 'e '.$MYVIMRC
command! RRC exec 'source '.$MYVIMRC.' | call lightline#update() | PackerCompile'
command! CDF :cd %:p:h
command! Rest :e ~/.rest
command! Q :q
command! W :w
command! Find :silent NERDTreeFind
command! RS LspRestart
command! Diff Gitsigns diffthis


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


""" command-related functions
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

" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! FindFileInParents(filename)
  let cwd = getcwd()
  while cwd != $HOME && cwd != '/'
    let filepath = cwd.'/'.a:filename
    if filereadable(filepath)
      return filepath
    endif
    let cwd = fnamemodify(cwd, ':h')
  endwhile
  return ''
endfunction

command! -nargs=0 Jumps call <SID>jumps_to_qf()
function! s:jumps_to_qf()
   redir => raw
   silent jumps
   redir END
python3 << EOF
import os
import re
import vim
jumplist = vim.eval("raw").split("\n")
jumpcols = jumplist[1]
filestart = jumpcols.find('file/text')
def format_row(row):
  matches = re.findall('\d+', row)[:3]
  if len(matches) < 3:
    return
  _, line, col = matches
  filename = row[filestart:].strip()
  filename = re.sub('^~', os.environ['HOME'], filename)
  if not os.path.exists(filename):
    return
  return {
    "col": col,
    "filename": filename,
    "lnum": line
  }
jumplist = jumplist[2:]
jumplist.reverse()
formatted_jumplist = [format_row(i) for i in jumplist]
qflist = [i for i in formatted_jumplist if i]
EOF
  let qf_output = py3eval("qflist")
  call setqflist(qf_output)
  copen
endfunction

command! -nargs=0 -bang Cleanup call <SID>cleanup_buffers("<bang>")
function! s:cleanup_buffers(...)
  norm m0
  silent exec "w | %bd".a:1." | e#"
  norm '0
  silent exec "bd #"
  norm zz
endfunction
