return {
  'nvim-lualine/lualine.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'general', 'statusLine' },
  event = 'VeryLazy',
  opts = {},
}
