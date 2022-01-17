local nvim_lsp = require('lspconfig')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)

-- keybindings
local on_attach = function(client, bufnr)
  require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- helpers
  local opts = { noremap=true, silent=true }
  local function keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- info
  keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- navigation
  keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references({ entry_maker = require("config.telescope")._qf_as_filenames()})<CR>', opts)
  keymap('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', opts)

  -- diagnostics
  keymap('n', '<leader>d', '<cmd>Telescope lsp_workspace_diagnostics<CR>', opts)
  keymap('n', '<leader>c', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ enable_popup = false })<CR>', opts)
  keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ enable_popup = false })<CR>', opts)

  -- actions
  keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap('n', '<leader>q', '<cmd>Telescope lsp_code_actions<CR>', opts)
  keymap('n', '<leader>a', '<cmd>Telescope lsp_code_actions<CR>', opts)

  -- auto formatting & delete trailing newline
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup LspAutocommands
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua local pos = vim.api.nvim_win_get_cursor(0); vim.lsp.buf.formatting_sync(); vim.cmd("$g/^$/d"); vim.api.nvim_win_set_cursor(0, pos)
      augroup END
    ]], true)
  end

  -- -- show diagnostics on hover
  -- vim.api.nvim_exec([[
  --   augroup LspHover
  --     autocmd!
  --     autocmd CursorHold * lua require('lspsaga.diagnostic').show_cursor_diagnostics()
  --   augroup END
  -- ]], true)
end

local flags = {
  debounce_text_changes = 150,
}


-- setup for most servers
local simple_servers = {
  'bashls', 'cssls', 'dockerls', 'html', 'jsonls', 'prismals',
  'pyright', 'svelte', 'tailwindcss', 'vimls', 'yamlls',
}
for _, lsp in ipairs(simple_servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = flags,
  }
end

-- ts + gql
nvim_lsp.tsserver.setup {
  on_attach = function(client)
    -- let diagnosticls (setup below) handle the formatting
    client.resolved_capabilities.document_formatting = false
    on_attach(client)
  end,
  flags = flags,
}
nvim_lsp.graphql.setup {
  on_attach = on_attach,
  flags = flags,
  filetypes = { 'graphql', 'typescript' },
}

-- luals
local luals_root_path = os.getenv('HOME')..'/.lua-language-server'
local luals_bin_path = luals_root_path..'/bin/macOS/lua-language-server'
nvim_lsp.sumneko_lua.setup {
  on_attach = on_attach,
  flags = flags,
  cmd = { luals_bin_path, '-E', luals_root_path..'/main.lua' },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true)
      },
    },
  },
}

-- eslint & prettier
local dls_filetypes = {
  typescript = "eslint",
  typescriptreact = "eslint",
  javascript = "eslint",
  javascriptreact = "eslint",
}
local dls_linters = {
  eslint = {
    sourceName = "eslint",
    command = "eslint_d",
    rootPatterns = {".eslintrc.js", "package.json"},
    debounce = 100,
    args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
    parseJson = {
      errorsRoot = "[0].messages",
      line = "line",
      column = "column",
      endLine = "endLine",
      endColumn = "endColumn",
      message = "${message} [${ruleId}]",
      security = "severity"
    },
    securities = {[2] = "error", [1] = "warning"}
  }
}
local dls_formatters = {
  prettier = {
    command = "prettier",
    args = {"--stdin-filepath", "%filepath"},
  }
}
local dls_formatFiletypes = {
  typescript = "prettier",
  typescriptreact = "prettier",
  javascript = "prettier",
  javascriptreact = "prettier",
  graphql = "prettier",
}
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = vim.tbl_keys(dls_filetypes),
  init_options = {
    filetypes = dls_filetypes,
    linters = dls_linters,
    formatters = dls_formatters,
    formatFiletypes = dls_formatFiletypes
  }
}
