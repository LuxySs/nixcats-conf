return {
  'stevearc/conform.nvim',
  enabled = require('nixCatsUtils').enableForCategory({ 'conform.core' }),

  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },

  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      python = { 'ruff_format' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
    },

    format_on_save = function(bufnr)
      -- Disable autoformat on certain languages that don't
      -- have a well standardized coding style (c, cpp, ...).
      local disable_lsp_fallback_filetypes = { c = true, cpp = true }
      if disable_lsp_fallback_filetypes[vim.bo[bufnr].filetype] then
        return
      end

      -- Disable autoformat with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end,
  },
}
