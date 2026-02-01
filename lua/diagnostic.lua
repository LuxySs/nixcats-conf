local map = vim.keymap.set

map('n', '<C-W>d', vim.diagnostic.open_float, { desc = 'Diagnostics Float Window' })

map('n', '[d', function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = 'Prev Diagnostic' })

map('n', ']d', function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = 'Next Diagnostic' })

-- Keymap to toggle virtual_lines
map('n', '<leader>vl', function()
  local current = vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({
    virtual_lines = not current,
  })
end, { desc = 'Toggle [V]irtual [L]ines' })

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '<U+F015A> ',
      [vim.diagnostic.severity.WARN] = '<U+F002A> ',
      [vim.diagnostic.severity.INFO] = '<U+F02FD> ',
      [vim.diagnostic.severity.HINT] = '<U+F0336> ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})
