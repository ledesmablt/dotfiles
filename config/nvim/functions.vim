""" functions
""" one-liner commands
command! CDF :cd %:p:h
command! Q :q
command! W :w
command! RS LspRestart
command! Diff Gitsigns diffthis


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

command! -nargs=0 -bang Cleanup call <SID>cleanup_buffers("<bang>")
function! s:cleanup_buffers(...)
  norm m0
  silent exec "w | %bd".a:1." | e#"
  norm '0
  silent exec "bd #"
  norm zz
endfunction

command! -nargs=0 Format lua vim.lsp.buf.formatting_sync()
