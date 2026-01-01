local linters_by_ft = {
  markdown = { 'markdownlint' },
  python = { 'ruff' },
}

return {
  'mfussenegger/nvim-lint',
  enabled = require('nixCatsUtils').enableForCategory({ 'core' }),

  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = linters_by_ft

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
