return {
  'stevearc/oil.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'general' }),
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,

  config = function()
    local oil = require('oil')
    oil.setup()

    local map = vim.keymap.set
    map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
