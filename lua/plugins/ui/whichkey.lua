return {
  'folke/which-key.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'ui', 'which-key' },
  event = 'VimEnter',
  opts = {},
}
