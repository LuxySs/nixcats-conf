return {
  'nvim-treesitter/nvim-treesitter',
  enabled = require('nixCatsUtils').enableForCategory({ 'general' }),

  event = 'VeryLazy',
  lazy = false,

  build = require('nixCatsUtils').lazyAdd(':TSUpdate'),

  opts = {
    install = require('nixCatsUtils').lazyAdd({ 'bash', 'c', 'cpp', 'lua', 'markdown', 'python', 'rust' }),
  },
}
