return {
  'catgoose/nvim-colorizer.lua',
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'colorizer' },
  cmd = { 'ColorizerToggle' },
  opts = {
    user_default_options = { mode = 'foreground' },
  },
}
