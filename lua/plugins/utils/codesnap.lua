return {
  'mistricky/codesnap.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'codesnap' },

  cmd = { 'CodeSnap' },

  build = require('nixCatsUtils').lazyAdd 'make',
  opts = {
    mac_window_bar = false,
    watermark = '',
    has_line_number = false,
    bg_x_padding = 20,
    bg_y_padding = 20,
  },
}
