return {
  'folke/todo-comments.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'general', 'todo-comments' }),
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
}
