local map = vim.keymap.set

-- Neovide (Neovim GUI) specific
if vim.g.neovide then
  vim.g.guifont = 'Iosevka NF:h15'

  -- Cursor
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_length = 0

  -- KEYMAPS
  -- change scale
  map('n', '<C-=>', '<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>', { silent = true })
  map('n', '<C-->', '<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>', { silent = true })

  -- change transparency
  map('n', '<C-+>', '<cmd>lua vim.g.neovide_transparency = vim.g.neovide_transparency + 0.05<CR>', { silent = true })
  map('n', '<C-_>', '<cmd>lua vim.g.neovide_transparency = vim.g.neovide_transparency - 0.05<CR>', { silent = true })

  map('n', '<C-0>', '<cmd>lua vim.g.neovide_scale_factor = 1<CR>', { silent = true }) -- reset scale
  map('n', '<C-)>', '<cmd>lua vim.g.neovide_transparency = 1<CR>', { silent = true }) -- reset transparency (opaque)
end
