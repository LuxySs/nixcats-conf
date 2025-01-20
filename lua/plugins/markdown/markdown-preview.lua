return {
  'iamcco/markdown-preview.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'markdown' },
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    if not require('nixCatsUtils').isNixCats then
      vim.fn['mkdp#util#install']()
    end
  end,
}
