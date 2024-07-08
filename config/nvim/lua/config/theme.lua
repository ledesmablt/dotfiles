local M = {}

M.init = function(use)
  -- colorscheme
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      local catppuccin = require('catppuccin')
      catppuccin.setup {
        integrations = {
          cmp = true,
          treesitter = true,
          gitsigns = true,
        },
      }
      vim.cmd [[colo catppuccin-mocha]]
    end
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    ensure_dependencies = true,
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin'
        }
      }
    end
  }
end

return M
