return {
  'OXY2DEV/markview.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'markdown', 'markview' }),
  lazy = false,
  priority = 49,

  dependencies = {
    -- You will not need this if you installed the
    -- parsers manually
    -- Or if the parsers are in your $RUNTIMEPATH
    'nvim-treesitter/nvim-treesitter',

    'nvim-tree/nvim-web-devicons',
  },
}
