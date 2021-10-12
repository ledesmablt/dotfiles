local function reload(name)
  require('plenary.reload').reload_module(name, true)
  return require(name)
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- essentials
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- visuals
  use { 'lewis6991/gitsigns.nvim', tag = 'release' }

  -- telescope
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use 'camgraff/telescope-tmux.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  reload('config.cmp')
  reload('config.gitsigns')
  reload('config.lsp')
  reload('config.telescope')
  reload('config.treesitter')
end)
