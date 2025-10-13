return {
  'chomosuke/typst-preview.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'typst', 'typst-preview' }),
  cmd = { 'TypstPreview' },
  ft = { 'typst' },
  version = '1.*',
  opts = {
    invert_colors = 'auto',
  },
}
