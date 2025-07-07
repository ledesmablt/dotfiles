-- User commands and utility functions

vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('RS', 'LspRestart', {})

-- Wipe matching buffers
local function wipe_matching_buffers(pattern)
  local bufferlist = {}
  for i = 1, vim.fn.bufnr('$') do
    if vim.fn.buflisted(i) == 1 then
      table.insert(bufferlist, i)
    end
  end
  
  local matchlist = {}
  for _, bufnr in ipairs(bufferlist) do
    local bufname = vim.fn.bufname(bufnr)
    if string.match(bufname, pattern) then
      table.insert(matchlist, bufnr)
    end
  end
  
  if #matchlist < 1 then
    print('No buffers found matching pattern ' .. pattern)
    return
  end
  
  for _, bufnr in ipairs(matchlist) do
    vim.cmd('bwipeout ' .. bufnr)
  end
end

vim.api.nvim_create_user_command('BW', function(opts)
  wipe_matching_buffers(opts.args)
end, { nargs = 1 })

-- Cleanup buffers
local function cleanup_buffers(bang)
  -- Save current position
  vim.cmd('normal! m0')
  
  -- Build command with optional bang
  local cmd = 'write | %bdelete'
  if bang and bang ~= '' then
    cmd = cmd .. bang
  end
  cmd = cmd .. ' | edit#'
  
  vim.cmd('silent ' .. cmd)
  
  -- Restore position and clean up
  vim.cmd('normal! \'0')
  vim.cmd('silent bdelete #')
  vim.cmd('normal! zz')
end

vim.api.nvim_create_user_command('Cleanup', function(opts)
  cleanup_buffers(opts.bang and '!' or '')
end, { bang = true })
