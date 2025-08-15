return {
  'windwp/nvim-autopairs',
  enabled = require('nixCatsUtils').enableForCategory({ 'general', 'autopairs' }),

  event = 'InsertEnter',

  opts = {},
}
