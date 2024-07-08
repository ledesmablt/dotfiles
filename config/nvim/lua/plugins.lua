local function reload(name)
  require('plenary.reload').reload_module(name, true)
  return require(name)
end

return require('packer').startup(function()
  -- this package manager
  use 'wbthomason/packer.nvim'

  -- lua helpers required by a handful of packages
  use 'nvim-lua/plenary.nvim'
  use 'svermeulen/vimpeccable'

  -- git diff lines and other utilities
  use {
    'lewis6991/gitsigns.nvim',
    config = function ()
      local gitsigns = require('gitsigns')
      gitsigns.setup {
        current_line_blame = true, -- show git blame to right of line
        on_attach = function(bufnr)
          -- helper function for keymapping
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- next hunk
          map('n', ']g', function()
            if vim.wo.diff then
              vim.cmd.normal({']g', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end)

          -- previous hunk
          map('n', '[g', function()
            if vim.wo.diff then
              vim.cmd.normal({'[g', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- open git blame for line in window
          map('n', '<leader>gb', gitsigns.blame_line)
        end
      }
    end
  }

  -- lang & completion
  use 'neovim/nvim-lspconfig' -- simple setup for different LSPs
  use 'williamboman/nvim-lsp-installer' -- easy functions like :LspInstall, :LspInfo

  -- the standard for syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    lazy = false, -- load synchronously when booting
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        ignore_install = { "phpdoc" }, -- buggy
        highlight = {
          enable = true,
        },
      }
      vim.opt.foldlevel = 20
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end
  }
  -- autocompletion (C-<space>)
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      -- {'quangnguyen30192/cmp-nvim-ultisnips'},
      {'onsails/lspkind.nvim'},
    }
  }

  -- CSS color highlighting - #f1f1f1
  use {
    'norcalli/nvim-colorizer.lua',
    config = function ()
      require('colorizer').setup()
    end
  }

  -- beautiful search menu
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      { 'gbrlsnchs/telescope-lsp-handlers.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
  }

  -- file manager
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

  -- terminal :Term
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
