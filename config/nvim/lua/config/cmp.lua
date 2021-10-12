local cmp = require('cmp')

vim.o.completeopt = "menu,menuone,noselect"
cmp.setup {
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'ultisnips' },
    -- { name = 'buffer' },
  },
  completion = {
    keyword_length = 3,
  },
  experimental = {
    ghost_text = cmp.GhostTextConfig,
  },
}
