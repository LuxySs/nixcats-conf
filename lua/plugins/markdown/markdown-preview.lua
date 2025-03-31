return {
  'iamcco/markdown-preview.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'markdown' },
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = require('nixCatsUtils').lazyAdd(function()
    vim.fn['mkdp#util#install']()
  end),
}
