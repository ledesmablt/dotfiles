local nvim_lsp = require('lspconfig')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  -- how to reflect file diagnostics when done
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
  }
)

-- keybindings
local on_attach = function(client, bufnr)
  -- cmp comletion
  require('cmp_nvim_lsp').default_capabilities()

  -- totally forgot what this is for
  if client.server_capabilities.colorProvider then
    require('config.lsp-documentcolors').buf_attach(bufnr)
  end

  -- helper functions
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
  -- keymap('n', 'gs', '<cmd>lua require("config.telescope").workspace_symbols_with_input()<CR>', opts)
  keymap('n', 'gs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
  keymap('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', opts)

  -- diagnostics
  keymap('n', '<leader>d', '<cmd>Telescope diagnostics<CR>', opts)
  keymap('n', '<leader>c', '<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>', opts)
  keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ enable_popup = false })<CR>', opts)
  keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ enable_popup = false })<CR>', opts)

  -- actions
  keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap('n', '<space>rm', '<cmd>TSLspRenameFile<CR>', opts)
  keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- auto format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_exec([[
      augroup LspAutocommands
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
    ]], true)
  end
end

local flags = {
  debounce_text_changes = 150,
}

-- setup with lspinstall
local lspinstall = require('nvim-lsp-installer')
lspinstall.setup()

-- setup for most servers
local simple_servers = {
  'bashls', 'cssls', 'dockerls', 'html', 'jsonls', 'prismals',
  'pyright', 'svelte', 'tailwindcss', 'vimls', 'yamlls', 'golangci_lint_ls', 'gopls',
}
for _, lsp in ipairs(simple_servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = flags,
  }
end

-- ruby
nvim_lsp.solargraph.setup {
  init_options = {
    formatting = false,
  },
  settings = {
    solargraph = { diagnostics = false }
  },
  on_attach = on_attach,
  flags = flags,
  cmd = { os.getenv('HOME')..'/.asdf/shims/solargraph', 'stdio' }
}

-- lua
local luals_root_path = os.getenv('HOME')..'/.lua-language-server'
local luals_bin_path = luals_root_path..'/bin/macOS/lua-language-server'
nvim_lsp.lua_ls.setup {
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

-- ts + gql
nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    -- let diagnosticls (setup below) handle the formatting.
    -- tsserver doesn't respect prettierrc.
    client.server_capabilities.documentFormattingProvider = false
    on_attach(client, bufnr)
  end,
  flags = flags,
}
nvim_lsp.graphql.setup {
  on_attach = on_attach,
  flags = flags,
  filetypes = { 'graphql', 'typescript', 'typescriptreact' },
}

-- eslint & prettier
local dls_filetypes = {
  typescript = "eslint",
  typescriptreact = "eslint",
  javascript = "eslint",
  javascriptreact = "eslint",
  ["typescript.tsx"] = "eslint",
  ["javascript.jsx"] = "eslint",
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
  ["typescript.tsx"] = "prettier",
  ["javascript.jsx"] = "prettier",
}
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = vim.tbl_keys(dls_filetypes),
  init_options = {
    formatters = dls_formatters,
    formatFiletypes = dls_formatFiletypes
  }
}
