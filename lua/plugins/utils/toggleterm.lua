return {
  'akinsho/toggleterm.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'toggleterm' },
  event = 'VeryLazy',
  version = '*',
  opts = {
    open_mapping = [[<c-\>]],
  },
}
