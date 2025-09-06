return {
  'chomosuke/typst-preview.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'typst', 'typst-preview' }),
  ft = 'typst',
  version = '1.*',
  opts = {},
}
