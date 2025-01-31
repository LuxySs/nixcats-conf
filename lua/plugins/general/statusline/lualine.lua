return {
  'nvim-lualine/lualine.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'general', 'statusLine' },
  lazy = false,
  event = 'VeryLazy',
  opts = {},
}
