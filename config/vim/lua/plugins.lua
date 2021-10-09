return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- essentials
  use 'nvim-lua/plenary.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- telescope
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use 'camgraff/telescope-tmux.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'

  -- load configs
  require('config/telescope')
  require('config/treesitter')
end)

