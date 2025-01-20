return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  enabled = require('nixCatsUtils').enableForCategory { 'utils', 'ufo' },
  event = 'VeryLazy',
  config = function()
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`.
    local map = vim.keymap.set
    map('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
    map('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    map('n', 'zK', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek Fold' })

    require('ufo').setup {
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }
  end,
}
