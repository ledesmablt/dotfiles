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
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']g', function()
        if vim.wo.diff then
          vim.cmd.normal({']g', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end)

      map('n', '[g', function()
        if vim.wo.diff then
          vim.cmd.normal({'[g', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end)
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
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim', 'jose-elias-alvarez/null-ls.nvim' }
  }
  use {
    'stevearc/conform.nvim',
    config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					-- python = { "isort", "black" },
					-- You can customize some of the format options for the filetype (:help conform.format)
					-- rust = { "rustfmt", lsp_format = "fallback" },
					-- Conform will run the first available formatter
					-- ruby = { "rubocop" },
					javascript = { "prettierd" },
					typescript = { "prettierd" },
					javascriptreact = { "prettierd" },
					typescriptreact = { "prettierd" },
				},
			})
    end
  }
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
        ignore_install = { "phpdoc", "ipkg" }, -- buggy
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
  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    config = function()
      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter','indent'}
        end
      })
      -- vim.o.foldcolumn = 0
      vim.o.foldenable = true
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end
  }

  -- menus
  use { 'ThePrimeagen/harpoon' }
  use {
    'SmiteshP/nvim-navic',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-navic').setup()
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
    ensure_dependencies = true,
    requires = {
      'arcticicestudio/nord-dircolors',
      'kyazdani42/nvim-web-devicons',
    },
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

  -- vim-plug plugins converted to packer
  use {
    'mbbill/undotree',
    config = function()
      vim.g.undotree_SplitWidth = 30
    end
  }
  use {
    'ledesmablt/vim-run',
    config = function()
      vim.g.run_autosave_logs = 1
      vim.g.run_quiet_default = 1
      vim.g.run_nostream_default = 1
    end
  }
  use {
    'junegunn/vim-peekaboo',
    config = function()
      vim.g.peekaboo_delay = 900
    end
  }
  use {
    'machakann/vim-highlightedyank',
    config = function()
      vim.g.highlightedyank_highlight_duration = 400
    end
  }
  use 'mattn/emmet-vim'
  use 'tpope/vim-abolish'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-rails'
  use 'gukz/ftFT.nvim'

  use {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsEnableSnipMate = 0
      vim.g.UltiSnipsEditSplit = 'horizontal'
      vim.g.UltiSnipsExpandTrigger = "<c-j>"
    end
  }


  -- external config files
  reload('config.theme').init(use)
  reload('config.telescope')
  reload('config.cmp')
  reload('config.lsp')
end)