return {
  'lervag/vimtex',
  enabled = require('nixCatsUtils').enableForCategory { 'latex' },
  lazy = false, -- lazy-loading will disable inverse search
  config = function()
    vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } } -- disable `K` as it conflicts with LSP hover
    vim.g.vimtex_view_method = 'zathura'
  end,
}
