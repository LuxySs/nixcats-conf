return {
  'lervag/vimtex',
  enabled = require('nixCatsUtils').enableForCategory({ 'latex', 'vimtex' }),
  lazy = false, -- lazy-loading will disable inverse search
  config = function()
    vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } } -- disable `K` as it conflicts with LSP hover
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
      out_dir = 'build',
    }
  end,
}
