return {
  'iamcco/markdown-preview.nvim',
  enabled = require('nixCatsUtils').enableForCategory { 'markdown' },
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = function()
    if not require('nixCatsUtils').isNixCats then
      vim.fn['mkdp#util#install']()
    end
  end,
}
