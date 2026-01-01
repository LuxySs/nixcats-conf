return {
  'catppuccin/nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'general', 'colorschemes' }),

  name = 'catppuccin-nvim',
  dev = require('nixCatsUtils').lazyAdd(false, true),

  lazy = true,
  priority = 1000,
}
