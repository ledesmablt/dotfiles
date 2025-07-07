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
  require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- if client.server_capabilities.colorProvider then
  --   require('config.lsp-documentcolors').buf_attach(bufnr)
  -- end

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
  -- keymap('n', 'gs', '<cmd>lua require("config.telescope").workspace_symbols_with_input()<CR>', opts)
  keymap('n', 'gs', '<cmd>Telescope lsp_document_symbols<CR>', opts)
  keymap('n', '<leader>gi', '<cmd>Telescope lsp_implementations<CR>', opts)

  -- diagnostics
  keymap('n', '<leader>d', '<cmd>Telescope diagnostics<CR>', opts)
  keymap('n', '<leader>c', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ enable_popup = false })<CR>', opts)
  keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ enable_popup = false })<CR>', opts)

  -- actions
  keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap('n', '<space>rm', '<cmd>TSLspRenameFile<CR>', opts)
  keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- auto formatting & delete trailing newline
  -- if client.server_capabilities.document_formatting then
  --   vim.api.nvim_exec([[
  --     augroup LspAutocommands
  --       autocmd! * <buffer>
  --       autocmd BufWritePre <buffer> lua local pos = vim.api.nvim_win_get_cursor(0); vim.lsp.buf.format(); vim.cmd("$g/^$/d"); if (pos[1] < vim.fn.line('$')) then vim.api.nvim_win_set_cursor(0, pos); end
  --     augroup END
  --   ]], true)
  -- end

  -- -- show diagnostics on hover
  -- vim.api.nvim_exec([[
  --   augroup LspHover
  --     autocmd!
  --     autocmd CursorHold * lua require('lspsaga.diagnostic').show_cursor_diagnostics()
  --   augroup END
  -- ]], true)

  if client.server_capabilities.document_formatting then
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
  end
end

local flags = {
  debounce_text_changes = 150,
}

local simple_servers = {
  'bashls', 'html', 'jsonls', 'prismals',
  'pyright', 'svelte', 'tailwindcss', 'vimls', 'yamlls',
  'diagnosticls', 'lua_ls',
  'bashls', 'dockerls', 'html', 'jsonls', 'prismals',
  'pyright', 'svelte', 'tailwindcss', 'vimls', 'yamlls',
  'golangci_lint_ls', 'gopls', 'rubocop',
}
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = simple_servers
}

for _, lsp in ipairs(simple_servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = flags,
  }
end

nvim_lsp.solargraph.setup {
  -- cmd = { 'bundle', 'exec solargraph stdio' },
  cmd = { os.getenv('HOME')..'/.asdf/shims/solargraph', 'stdio' },
  init_options = { formatting = false },
  settings = { solargraph = { diagnostics = false }},
}

-- ts + gql
nvim_lsp.ts_ls.setup {
  init_options = require('nvim-lsp-ts-utils').init_options,
  on_attach = function(client, bufnr)
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup {
      auto_inlay_hints = false,
      always_organize_imports = false,
    }
    -- let diagnosticls (setup below) handle the formatting
    client.server_capabilities.document_formatting = true
    on_attach(client, bufnr)
  end,
  flags = flags,
}
nvim_lsp.graphql.setup {
  on_attach = on_attach,
  flags = flags,
  filetypes = { 'graphql', 'typescript', 'typescriptreact' },
}
