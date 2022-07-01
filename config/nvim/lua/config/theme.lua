local M = {}

M.init = function(use)
  -- colorscheme
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      local catppuccin = require('catppuccin')
      catppuccin.setup {
        styles = {
          keywords = 'NONE',
          variables = 'NONE',
          functions = 'NONE',
        },
      }
      local colors = require('catppuccin.api.colors').get_colors()
      catppuccin.remap {
        TSFuncBuiltin = { fg = colors.peach, style = "NONE" },
        TSVariableBuiltin = { fg = colors.teal, style = "NONE" },
        TSParameter = { fg = colors.rosewater, style = "NONE" },
        TSMethod = { fg = colors.blue, style = "NONE" },
        TSNamespace = { fg = colors.rosewater, style = "NONE" },
        TSProperty = { fg = colors.yellow, style = "NONE" },
        TSType = { fg = colors.yellow, style = "italic" },
        typescriptTSProperty = { fg = colors.lavender, style = "NONE" },
      }
      vim.cmd [[colo catppuccin]]
    end
  }

  -- statusline
  use {
    'feline-nvim/feline.nvim',
    ensure_dependencies = true,
    requires = {{
      'kyazdani42/nvim-web-devicons',
    }},
    config = function ()
      local feline = require('feline')
      local cp_components = require('catppuccin.core.integrations.feline')
      -- feline.setup {
      --   components = cp_components
      -- }
      local cp_colors = require('catppuccin.core.color_palette')
      local active1 = cp_components.active[1]
      local active14 = active1[4]
      active14["enabled"] = true

      local gps = require('nvim-gps')

      feline.setup {
        components = {
          active = {
            {
              active1[1], active1[2], active1[3], active14,
              {
                -- empty space
                provider = function()
                  return " "
                end,
                hl = {
                  fg = cp_colors.gray1,
                  bg = cp_colors.black3,
                },
              },
              {
                -- nvim gps
                provider = function()
                  return gps.get_location()
                end,
                enabled = function()
                  return gps.is_available()
                end,
                hl = {
                  fg = cp_colors.gray1,
                  bg = cp_colors.black3,
                },
              }
            },
            cp_components.active[2],
            { unpack(cp_components.active[3], 1, 3) },
          },
          inactive = cp_components.inactive
        }
      }
    end
  }
end

return M
