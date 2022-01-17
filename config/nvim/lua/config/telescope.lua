local utils = require "telescope.utils"
local entry_display = require "telescope.pickers.entry_display"
local actions = require('telescope.actions')
local _telescope = require('telescope.builtin')

require('telescope').setup {
  defaults = {
    dynamic_preview_title = true,
    layout_strategy = "vertical",
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      mirror = true,
      preview_cutoff = 30,
    },
    pickers = {
      command_history = {
        sorting_strategy = "descending",
      },
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-a>"] = actions.select_all,
      },
    },
  },
  extensions = {}
}

require('telescope').load_extension('fzf')

-- custom functions

local M = {}
M.search_dotfiles = function()
  _telescope.find_files({
    prompt_title = "Dotfiles",
    cwd = "~/projects/dotfiles"
  })
end

-- custom function for lsp_references entries
M._qf_as_filenames = function (opts)
  opts = opts or {}

  local displayer = entry_display.create {
    separator = "▏",
    items = {
      { width = 8 },
      { width = 50 },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    local filename = utils.transform_path(opts, entry.filename)
    local line_info = { table.concat({ entry.lnum, entry.col }, ":"), "TelescopeResultsLineNr" }

    return displayer {
      line_info,
      filename,
    }
  end

  return function(entry)
    local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)

    return {
      valid = true,

      value = entry,
      ordinal = (not opts.ignore_filename and filename or "") .. " " .. entry.text,
      display = make_display,

      bufnr = entry.bufnr,
      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      text = entry.text,
      start = entry.start,
      finish = entry.finish,
    }
  end
end

return M
