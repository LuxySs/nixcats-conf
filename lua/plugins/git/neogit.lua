return {
  'NeogitOrg/neogit',

  enabled = require('nixCatsUtils').enableForCategory { 'git' },

  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'nvim-telescope/telescope.nvim', -- optional
  },

  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
  },
}
