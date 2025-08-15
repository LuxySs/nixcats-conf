return {
  'catgoose/nvim-colorizer.lua',
  enabled = require('nixCatsUtils').enableForCategory({ 'general', 'colorizer' }),
  cmd = { 'ColorizerToggle' },
  opts = {
    user_default_options = { mode = 'foreground' },
  },
}
