return {
  'nvim-lualine/lualine.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'general', 'lualine' }),
  event = 'VeryLazy',
  opts = {},
}
