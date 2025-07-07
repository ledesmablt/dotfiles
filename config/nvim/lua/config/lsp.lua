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
  require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

  -- auto formatting
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
  })
end

local flags = {
  debounce_text_changes = 150,
}

local simple_servers = {
  'bashls', 'html', 'jsonls', 'prismals',
  'pyright', 'svelte', 'tailwindcss', 'yamlls',
  'dockerls', 'golangci_lint_ls', 'gopls', 'rubocop',
  'solargraph', 'ts_ls',
}
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = simple_servers,
  automatic_enable = false,
}

for _, lsp in ipairs(simple_servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = flags,
  }
end