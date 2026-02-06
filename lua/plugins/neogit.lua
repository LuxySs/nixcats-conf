return {
  "NeogitOrg/neogit",
  enabled = require('nixCatsUtils').enableForCategory({ 'neogit' }),
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    "folke/snacks.nvim",      -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
  }
}
