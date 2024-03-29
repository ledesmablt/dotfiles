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
  use {
    'anuvyklack/hydra.nvim',
    config = function()
      local Hydra = require('hydra')
      Hydra({
        name = 'Windows',
        mode = 'n',
        body = '<C-w>',
        heads = {
          { 'h', '<C-w>h' },
          { 'j', '<C-w>j' },
          { 'k', '<C-w>k' },
          { 'l', '<C-w>l' },

          { 'H', ':vnew<CR>' },
          { 'J', ':below new<CR>' },
          { 'K', ':new<CR>' },
          { 'L', ':below vnew<CR>' },

          { '[', ':resize -2<CR>' },
          { ']', ':resize +2<CR>' },
          { '{', ':vertical resize -2<CR>' },
          { '}', ':vertical resize +2<CR>' },
          { 'q', '<C-w>q' },
        }
      })
    end
  }

  -- lang & completion
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        ignore_install = { "phpdoc" }, -- buggy
        highlight = {
          enable = true,
        },
      }
    end
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      {'quangnguyen30192/cmp-nvim-ultisnips'},
      {'onsails/lspkind.nvim'},
    }
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function ()
      require('colorizer').setup()
    end
  }

  -- menus
  use { 'ThePrimeagen/harpoon' }
  use {
    'SmiteshP/nvim-gps',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-gps').setup()
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
  }
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('octo').setup()
    end
  }
  use {
    'ms-jpq/chadtree',
    run = ':CHADdeps',
    requires = { 'arcticicestudio/nord-dircolors' },
    config = function()
      vim.api.nvim_set_var("chadtree_settings", {
        ["keymap.change_dir"] = { "B" },
        ["keymap.refresh"] = { "<c-r>", "R" },
        ["keymap.primary"] = { "<enter>", "o" },
        ["keymap.h_split"] = { "go" },
        ["keymap.v_split"] = {},
        ["keymap.open_sys"] = { "O" },
        ["view.width"] = 35,
        ["view.window_options"] = {
          ["number"] = true,
          ["relativenumber"] = true,
        },
      })
    end
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
