local function reload(name)
  require('plenary.reload').reload_module(name, true)
  return require(name)
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- lua sugar
  use 'nvim-lua/plenary.nvim'
  use 'svermeulen/vimpeccable'

  -- editing
  use {
    'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function ()
      require('gitsigns').setup {
        keymaps = {
          ['n [g'] = '<cmd>Gitsigns prev_hunk<CR>',
          ['n ]g'] = '<cmd>Gitsigns next_hunk<CR>',
          ['n <space>gb'] = '<cmd>Gitsigns blame_line<CR>',
        }
      }
    end
  }

  -- lang & completion
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
        },
      }
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    ensure_dependencies = true,
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'quangnguyen30192/cmp-nvim-ultisnips'},
    }
  }

  -- menus
  use {
    'nvim-telescope/telescope.nvim',
    ensure_dependencies = true,
    requires = {{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }},
  }
  use {
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_height = 0.2
      vim.g.floaterm_position = 'bottomright'
      vim.g.floaterm_autoclose = 1
      vim.g.floaterm_keymap_new = '<F12>'
      vim.cmd(
        'command! -nargs=* -complete=file Term exec "FloatermNew \"<q-args>\"" | wincmd p | stopinsert'
      )
    end
  }

  -- external config files
  reload('config.theme').init(use)
  reload('config.telescope')
  reload('config.cmp')
  reload('config.lsp')
end)
