return {
  'stevearc/oil.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'oil' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  opts = {},
}
