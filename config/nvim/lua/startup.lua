-- Budget Startify - Custom startup screen

local M = {}

-- Configuration
local config = {
  sessionsave = vim.fn.getcwd() .. '/.session.vim',
  startup_img = vim.env.HOME .. '/.config/nvim/startup.txt'
}

-- Main initialization function
local function init()
  -- Only initialize if no arguments were passed and buffer is empty
  if vim.fn.argc() > 0 or vim.fn.line2byte('$') ~= -1 then
    return
  end

  -- Read the ASCII art file
  local ok, lines = pcall(vim.fn.readfile, config.startup_img)
  if not ok then
    -- If the file doesn't exist, just return
    return
  end

  -- Calculate dimensions
  local height = #lines
  local width = 1
  
  for _, line in ipairs(lines) do
    local line_width = vim.fn.strwidth(line)
    if line_width > width then
      width = line_width
    end
  end

  -- Get window dimensions
  local win_height = vim.api.nvim_win_get_height(0)
  local win_width = vim.api.nvim_win_get_width(0)

  -- Calculate top padding
  local n_space_top = math.floor((win_height - height) / 2.5)
  
  -- Add top padding
  for _ = 1, n_space_top do
    vim.fn.append('$', '')
  end

  -- Calculate left padding
  local n_space_left = math.floor((win_width - width) / 2)
  local left_padding = string.rep(' ', n_space_left)

  -- Draw ASCII art with left padding
  for _, line in ipairs(lines) do
    vim.fn.append('$', left_padding .. line)
  end

  -- Set buffer options
  vim.opt_local.colorcolumn = ''
  vim.opt_local.relativenumber = false
  vim.opt_local.number = false
  vim.opt_local.modifiable = false
  vim.opt_local.bufhidden = 'wipe'
  vim.opt_local.buftype = 'nowrite'
  vim.opt_local.filetype = 'myinitpage'
end

-- Set up autocommand
local augroup = vim.api.nvim_create_augroup("BudgetStartify", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = init,
  desc = "Show custom startup screen"
})

-- Export configuration for external access
M.config = config
M.init = init

return M
