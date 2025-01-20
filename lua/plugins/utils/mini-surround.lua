return {
  'echasnovski/mini.surround',
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'mini-surround' },
  event = 'VeryLazy',
  opts = {
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
  },
}
