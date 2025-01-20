return {
  'catppuccin/nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'general', 'colorschemes' },

  -- name = "catppuccin",
  name = 'catppuccin-nvim',
  dev = require('nixCatsUtils').lazyAdd(false, true),

  lazy = false,
  priority = 1000,

  config = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}
