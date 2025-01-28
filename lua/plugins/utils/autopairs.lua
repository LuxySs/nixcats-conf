return {
  'windwp/nvim-autopairs',
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'autopairs' },

  event = 'InsertEnter',

  opts = {},
}
