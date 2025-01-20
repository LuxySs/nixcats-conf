return {
  'nvim-lualine/lualine.nvim',
  enabled = require('nixCatsUtils').enableForCategory 'general',
  lazy = false,
  event = 'VeryLazy',
  opts = {},
}
