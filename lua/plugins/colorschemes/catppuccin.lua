return {
  'catppuccin/nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'colorschemes' }),

  name = 'catppuccin-nvim',
  dev = require('nixCatsUtils').lazyAdd(false, true),

  lazy = false,
  priority = 1000,
}
