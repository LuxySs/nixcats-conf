local map = vim.keymap.set

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- window resizing
map('n', '<M-h>', '<c-w>5<')
map('n', '<M-l>', '<c-w>5>')
map('n', '<M-k>', '<c-w>+')
map('n', '<M-j>', '<c-w>-')

-- File browser
map('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
