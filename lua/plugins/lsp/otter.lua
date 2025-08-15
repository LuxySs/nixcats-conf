return {
  'jmbuhr/otter.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'lsp' }),
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
    'saghen/blink.cmp',
  },
  ft = { 'nix', 'markdown' },
  config = function()
    local otter = require('otter')
    otter.activate({ 'bash', 'c', 'cpp', 'lua', 'nix', 'python', 'rust' }, true, true, nil)
  end,
}
