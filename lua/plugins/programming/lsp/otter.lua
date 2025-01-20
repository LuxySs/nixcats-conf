return {
  'jmbuhr/otter.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'programming', 'lsp', 'markdown' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
    'saghen/blink.cmp',
  },
  ft = { 'nix', 'markdown' },
  config = function()
    local otter = require 'otter'
    otter.activate({ 'bash', 'c', 'cpp', 'javascript', 'lua', 'python', 'rust' }, true, true, nil)
  end,
}
