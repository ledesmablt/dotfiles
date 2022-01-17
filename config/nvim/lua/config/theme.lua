local M = {}

M.init = function(use)
  -- colorscheme
  use {
    'catppuccin/nvim',
    as = 'catpuccin',
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
    requires = {{ 'kyazdani42/nvim-web-devicons' }},
    config = function ()
      local feline = require('feline')
      local cp_components = require('catppuccin.core.integrations.feline')
      local cp_colors = require('catppuccin.core.color_palette')
      feline.setup {
        components = {
          active = {
            cp_components.active[1],
            cp_components.active[2],
            { unpack(cp_components.active[3], 1, 3) },
          },
          inactive = {
            {
              {
                hl = function()
                  return {
                    fg = cp_colors.gray0,
                    bg = cp_colors.black3,
                  }
                end
              }
            },
            {
              {
                provider = function()
                  local filename = vim.fn.expand("%:t")
                  local extension = vim.fn.expand("%:e")
                  local icon = require("nvim-web-devicons").get_icon(filename, extension)
                  if icon == nil then
                    icon = "   "
                    return icon
                  end
                  return " " .. icon .. " " .. filename .. " "
                end,
                enabled = function(winid)
                  return vim.api.nvim_win_get_width(winid) > 70
                end,
                hl = function()
                  return {
                    fg = cp_colors.gray0,
                    bg = cp_colors.black3,
                  }
                end
              }
            }
          }
        }
      }
    end
  }
end

return M
