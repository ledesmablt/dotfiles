local utils = require('telescope.utils')
local entry_display = require('telescope.pickers.entry_display')
local actions = require('telescope.actions')
local _telescope = require('telescope.builtin')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')

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
      grep_string = {
        prompt_title = "Find Word",
        only_sort_text = true,
        path_display = { "smart" },
        -- search = '' doesn't work
      },
      buffers = {
        ignore_current_buffer = true,
        sort_lastused = true,
        -- sort_mru = true doesn't work
      }
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
require('telescope').load_extension('lsp_handlers')

-- custom functions

local M = {}
M.search_dotfiles = function()
  _telescope.find_files({
    prompt_title = "Dotfiles",
    cwd = "~/projects/dotfiles"
  })
end

M.workspace_symbols_with_input = function()
  vim.ui.input('Search for a workspace symbol: ', function(input)
    _telescope.lsp_workspace_symbols({
      query = input
    })
  end)
end

-- ripped from builtin.command_history but with a different sorter
M.command_history = function(opts)
  local history_string = vim.fn.execute "history cmd"
  local history_list = vim.split(history_string, "\n")

  local results = {}
  for i = #history_list, 3, -1 do
    local item = history_list[i]
    local _, finish = string.find(item, "%d+ +")
    table.insert(results, string.sub(item, finish + 1))
  end

  pickers.new(opts, {
    prompt_title = "Command History",
    finder = finders.new_table(results),
    sorter = sorters.fuzzy_with_index_bias(opts),

    attach_mappings = function(_, map)
      map("i", "<CR>", actions.set_command_line)
      map("n", "<CR>", actions.set_command_line)
      map("n", "<C-e>", actions.edit_command_line)
      map("i", "<C-e>", actions.edit_command_line)

      return true
    end,
  }):find()
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
