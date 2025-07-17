local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Window resizing
map('n', '<A-k>', ':resize +5<CR>', { desc = 'Increase window height' })
map('n', '<A-j>', ':resize -5<CR>', { desc = 'Decrease window height' })
map('n', '<A-h>', ':vertical resize -5<CR>', { desc = 'Decrease window width' })
map('n', '<A-l>', ':vertical resize +5<CR>', { desc = 'Increase window width' })

-- Delete without yanking
map({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without yanking' })

-- Move lines up/down
map('n', '<A-J>', ':m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-K>', ':m .-2<CR>==', { desc = 'Move line up' })
map('v', '<A-J>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-K>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Better indenting in visual mode
map('v', '<', '<gv', { desc = 'Indent left and reselect' })
map('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Clipboard stuff
map({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'y (system clipboard)' })
map('n', '<leader>Y', [["+Y]], { desc = 'Y (system clipboard)' })
map('x', '<leader>p', [["_dP]], { desc = 'Paste without overwriting register' })

-- Copy Full File-Path
map('n', '<leader>pa', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('file:', path)
end)

-- Copy Relative File-Path
map('n', '<leader>pr', function()
  local path = vim.fn.expand('%:.')
  vim.fn.setreg('+', path)
  print('file:', path)
end)
