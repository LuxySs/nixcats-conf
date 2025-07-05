return {
  'debugloop/telescope-undo.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'utils', 'telescope-undo' }),
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  event = 'VeryLazy',

  config = function()
    require('telescope').setup({
      -- the rest of your telescope config goes here
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- other extensions:
        -- file_browser = { ... }
      },
    })
    require('telescope').load_extension('undo')

    vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>')
  end,
}
