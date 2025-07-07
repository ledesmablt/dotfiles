local M = {}

M.init = function(use)
  -- theme
  use {
    'rebelot/kanagawa.nvim', 
    config = function()
      -- require('kanagawa').setup {}
      vim.cmd [[colo kanagawa]]
    end
  }

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    ensure_dependencies = true,
    requires = {{
      'kyazdani42/nvim-web-devicons',
    }},
    config = function ()
      require('lualine').setup {
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'},
        }
      }
    end
  }
end

return M
