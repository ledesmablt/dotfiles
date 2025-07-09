-- Key mappings

-- Set leader key
vim.g.mapleader = ' '

-- Helper function for key mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Filetype-specific mappings
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local ft_mappings_group = augroup("FTMappings", { clear = true })

autocmd("FileType", {
  group = ft_mappings_group,
  pattern = "man",
  callback = function()
    vim.keymap.set('n', 'q', ':q<CR>', { buffer = true, silent = true })
  end
})

-- Editing mappings
map('n', '<leader><Tab>', '<C-^>')
map('n', '<leader>o', 'i<CR><Esc>%a<CR>')
map('n', '<leader>t', 'oi<C-R>=')
map('v', '<leader>p', '"_dp<CR>')
map('v', '<leader>P', '"_dP<CR>')
map('n', 'Y', 'y$')

-- Alt key mappings for insert mode navigation
map('i', '<M-h>', '<C-o>h')
map('i', '<M-l>', '<C-o>l')
map('i', '<M-w>', '<C-o>w')
map('i', '<M-b>', '<C-o>b')
map('i', '<M-W>', '<C-o>W')
map('i', '<M-B>', '<C-o>B')

-- Select in/around "/"
map('n', 'vi/', 'T/vt/')
map('n', 'va/', 'F/vf/')

-- Start substitution on current/highlighted word
map('n', '<C-s>', ':%s/\\<<C-r><C-w>\\>/')
map('v', '<C-s>', '"0y:%s/\\<<C-r>0\\>/')

-- Commentary (C-_ is actually C-/)
map('n', '<C-_>', ':Commentary<CR>')
map('v', '<C-_>', ':Commentary<CR>')

map('n', '-', ':CHADopen --always-focus<CR>')

-- Window management
map('n', '<leader>h', ':wincmd h<CR>')
map('n', '<leader>j', ':wincmd j<CR>')
map('n', '<leader>k', ':wincmd k<CR>')
map('n', '<leader>l', ':wincmd l<CR>')
map('n', '<leader>H', ':vnew<CR>')
map('n', '<leader>J', ':below new<CR>')
map('n', '<leader>K', ':new<CR>')
map('n', '<leader>L', ':below vnew<CR>')
map('n', '<leader>tn', ':tabnext<CR>')
map('n', '<leader>tp', ':tabprevious<CR>')
map('n', '<leader>tt', ':tabnew<CR>')
map('n', '<M-[>', ':resize -2<CR>')
map('n', '<M-]>', ':resize +2<CR>')
map('t', '<C-W>', '<C-\\><C-N><C-W>')

-- Quickfix navigation
map('n', '<C-j>', ':cn<CR>')
map('n', '<C-k>', ':cp<CR>')
map('n', '<M-j>', ':cnewer<CR>')
map('n', '<M-k>', ':colder<CR>')

-- Utility mappings
map('n', '<leader><C-l>', ':e<CR>:redraw<CR>:set nu rnu<CR>')

-- Plugin mappings
map('n', '<leader>e', ':CHADopen<CR>')
map('n', '<leader>u', ':UndotreeToggle<CR>:UndotreeFocus<CR>')

-- Telescope search mappings
map('n', '<leader>gf', ':Telescope git_files<CR>')
map('n', '<leader>gg', ':Telescope git_status<CR>')
map('n', '<leader>f', ':Telescope find_files<CR>')
map('n', '<leader>/', ':Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>?', ':Telescope keymaps<CR>')
map('n', '<leader>b', ':Telescope buffers sort_mru=true ignore_current_buffer=true<CR>')
map('n', '<leader>ss', ':Telescope grep_string search=""<CR>')
map('n', '<leader>sg', ':Telescope live_grep<CR>')
map('n', '<leader>sq', ':Telescope quickfix<CR>')
map('n', '<leader>sf', ':Telescope oldfiles<CR>')
map('n', '<leader>sd', function() require('config.telescope').search_dotfiles() end)
map('n', '<leader>sD', function() require('config.telescope').search_downloads() end)
map('n', '<leader>sh', function() require('config.telescope').command_history() end)

-- Plugin-specific autocommands
local mappings_group = augroup("Mappings", { clear = true })

autocmd("FileType", {
  group = mappings_group,
  pattern = "chadtree",  -- Updated from nerdtree to chadtree
  callback = function()
    vim.keymap.set('n', '<leader>u', ':CHADclose<CR>:UndotreeToggle<CR>:UndotreeFocus<CR>', { buffer = true, silent = true })
  end
})

autocmd("FileType", {
  group = mappings_group,
  pattern = "undotree",
  callback = function()
    vim.keymap.set('n', '<leader>e', ':UndotreeHide<CR>:CHADopen<CR>', { buffer = true, silent = true })
  end
})

-- Rails app/spec file swapping function
local function swap_app_spec()
  local current_file = vim.fn.expand('%')
  local target_file = ''
  
  if string.match(current_file, '^app/') then
    target_file = string.gsub(current_file, '^app/', 'spec/')
    target_file = string.gsub(target_file, '%.rb$', '_spec.rb')
  elseif string.match(current_file, '^spec/') then
    target_file = string.gsub(current_file, '^spec/', 'app/')
    target_file = string.gsub(target_file, '_spec%.rb$', '.rb')
  else
    print("Not an app/ or spec/ file")
    return
  end
  
  vim.cmd('edit ' .. target_file)
end

-- Make function globally available and map it
_G.swap_app_spec = swap_app_spec
map('n', '<leader>y', function() swap_app_spec() end)
