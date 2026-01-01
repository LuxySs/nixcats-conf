return {
  'jmbuhr/otter.nvim',
  enabled = require('nixCatsUtils').enableForCategory({}),
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
  },

  config = function()
    local map = vim.keymap.set
    map('n', '<leader>oa', require('otter').activate, { desc = '[o]tter [a]ctivate' })
  end,
}
