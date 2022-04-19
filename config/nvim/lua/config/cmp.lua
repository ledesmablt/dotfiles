local cmp = require('cmp')

vim.o.completeopt = "menu,menuone,noselect"
cmp.setup {
  mapping = cmp.mapping.preset.insert{
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
  },
  sources = cmp.config.sources{
    -- { name = 'ultisnips' },
    -- { name = 'buffer' },
    { name = 'nvim_lsp' },
  },
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end
  },
  completion = {
    keyword_length = 3,
  },
  experimental = {
    ghost_text = true,
  },
}
