return {
  'chomosuke/typst-preview.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'typst' }),
  cmd = { 'TypstPreview' },
  ft = { 'typst' },
  version = '1.*',
  opts = {},
}
