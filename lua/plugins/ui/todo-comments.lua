return {
  'folke/todo-comments.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'ui', 'todo-comments' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VimEnter',
  opts = {},
}
