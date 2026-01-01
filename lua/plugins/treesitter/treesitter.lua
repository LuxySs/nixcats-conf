return {
  'nvim-treesitter/nvim-treesitter',
  enabled = require('nixCatsUtils').enableForCategory({
    'treesitter',
    'bash',
    'c',
    'cpp',
    'go',
    'latex',
    'lua',
    'nix',
    'python',
    'rust',
    'typescript',
  }),

  event = 'VeryLazy',
  lazy = false,

  build = require('nixCatsUtils').lazyAdd(':TSUpdate'),

  opts = {
    install = require('nixCatsUtils').lazyAdd({ 'bash', 'c', 'cpp', 'lua', 'markdown', 'python', 'rust' }),
  },
}
