local utils = require('telescope.utils')
local entry_display = require('telescope.pickers.entry_display')
local actions = require('telescope.actions')
local _telescope = require('telescope.builtin')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

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
        search = '',
        only_sort_text = true,
        path_display = { "smart" },
      },
      buffers = {
        ignore_current_buffer = true,
        sort_lastused = true,
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

-- custom functions

local M = {}
M.search_dotfiles = function()
  _telescope.find_files({
    prompt_title = "Dotfiles",
    cwd = "~/projects/dotfiles"
  })
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

M.file_history = function(opts)
  opts = opts or {}

  local results = {}

  local cwd = vim.loop.cwd()
  local home = os.getenv('HOME')
  local function clean_pathname(input)
    local no_cwd = (string.gsub(input, '^'..cwd..'/', ''))
    local no_home = (string.gsub(no_cwd, '^'..home, '~'))
    return no_home
  end

  -- ripped from builtin.buffers
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      return false
    end
    if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(b) then
      return false
    end
    if b == vim.api.nvim_get_current_buf() then
      return false
    end
    if opts.cwd_only and not string.find(vim.api.nvim_buf_get_name(b), vim.loop.cwd(), 1, true) then
      return false
    end
    return true
  end, vim.api.nvim_list_bufs())

  -- always sort most recent used
  table.sort(bufnrs, function(a, b)
    return vim.fn.getbuinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
  end)

  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == vim.fn.bufnr "" and "%" or (bufnr == vim.fn.bufnr "#" and "#" or " ")

    -- instead of an element, we get the name
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if (bufname == nil or bufname == '') then
      bufname = '[No name]:'..tostring(bufnr)
    end
    bufname = clean_pathname(bufname)
    local idx = ((buffers[1] ~= nil and buffers[1].flag == "%") and 2 or 1)
    table.insert(results, idx, bufname)
    table.insert(buffers, idx, { bufname = bufname, flag = flag })
  end

  local history_list = vim.v.oldfiles
  local current_bufnr = vim.api.nvim_get_current_buf()
  local current_bufname = vim.api.nvim_buf_get_name(current_bufnr)
  for i = 1, #history_list, 1 do
    local item = history_list[i]
    local filename = clean_pathname(item)
    local not_duplicate = not vim.tbl_contains(results, filename)
    local not_current_buf = item ~= current_bufname
    if (not_duplicate and not_current_buf) then
      table.insert(results, filename)
    end
  end

  pickers.new(opts, {
    prompt_title = "File History",
    finder = finders.new_table(results),
    sorter = sorters.fuzzy_with_index_bias(opts),
    previewer = conf.grep_previewer(opts),
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
