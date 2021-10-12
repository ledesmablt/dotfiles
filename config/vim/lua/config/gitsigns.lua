require('gitsigns').setup {
  keymaps = {
    ['n [g'] = '<cmd>Gitsigns prev_hunk<CR>',
    ['n ]g'] = '<cmd>Gitsigns next_hunk<CR>',
    ['n <space>gb'] = '<cmd>Gitsigns blame_line<CR>',
  }
}
