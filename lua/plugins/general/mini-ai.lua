return {
  'echasnovski/mini.ai',
  enabled = require('nixCatsUtils').enableForCategory({ 'general' }),
  event = 'VeryLazy',
  opts = {
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    n_lines = 500,
  },
}
