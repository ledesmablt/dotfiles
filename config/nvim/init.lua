-- Sane defaults
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.ruler = false
vim.opt.lazyredraw = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.showcmd = false
-- vim.opt.colorcolumn = "80"
vim.opt.updatetime = 300

vim.opt.path:append("**")
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

vim.opt.hidden = true
vim.opt.fixeol = false
vim.opt.autoread = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.errorbells = false

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- SyntaxSettings
local syntax_group = augroup("SyntaxSettings", { clear = true })

autocmd("FileType", {
    group = syntax_group,
    pattern = "*",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = syntax_group,
    pattern = "*doc/*.txt",
    callback = function()
        vim.opt_local.filetype = "help"
        vim.opt_local.tabstop = 8
        vim.opt_local.shiftwidth = 8
    end,
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = syntax_group,
    pattern = { "*.tsx", "*.jsx" },
    callback = function()
        vim.opt_local.filetype = "typescriptreact"
    end,
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = syntax_group,
    pattern = "*.njk",
    callback = function()
        vim.opt_local.filetype = "html"
    end,
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = syntax_group,
    pattern = "*.jbuilder",
    callback = function()
        vim.opt_local.filetype = "ruby"
    end,
})
autocmd("FileType", {
    group = syntax_group,
    pattern = { "python", "markdown" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})
autocmd("FileType", {
    group = syntax_group,
    pattern = "git",
    callback = function()
        vim.opt_local.foldlevel = 1
    end,
})

-- ReloadConfig
local reload_config_group = augroup("ReloadConfig", { clear = true })
autocmd("BufWritePost", {
  group = reload_config_group,
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile"
})

-- Tmux display fix
if vim.fn.exists('+termguicolors') == 1 then
--   vim.opt.t_8f = "\27[38;2;%lu;%lu;%lum"
--   vim.opt.t_8b = "\27[48;2;%lu;%lu;%lum"
  vim.opt.termguicolors = true
end

-- Load other configuration files
require('plugins')
vim.cmd('source ~/.config/nvim/plugins.vim')
vim.cmd('source ~/.config/nvim/functions.vim')
vim.cmd('source ~/.config/nvim/mappings.vim')
vim.cmd('source ~/.config/nvim/budget_startify.vim')