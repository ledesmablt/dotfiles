local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require('telescope.actions')
local _telescope = require('telescope.builtin')

require('telescope').setup {
  defaults = {
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
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
  pickers = {},
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

-- test: not working??
M.colors = function(opts)
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_table {
      results = { "red", "green", "blue" }
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

return M
