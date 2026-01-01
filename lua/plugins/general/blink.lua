return {
  'saghen/blink.cmp',
  enabled = require('nixCatsUtils').enableForCategory({ 'blink' }),
  event = 'InsertEnter',
  version = '1.*',

  dependencies = {
    'L3MON4D3/LuaSnip',
    enabled = require('nixCatsUtils').enableForCategory({ 'blink' }),
    lazy = true,

    name = 'luasnip',
    dev = require('nixCatsUtils').lazyAdd(false, true),

    version = 'v2.*',

    build = require('nixCatsUtils').lazyAdd((function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
        return
      end
      return 'make install_jsregexp'
    end)()),

    dependencies = { 'rafamadriz/friendly-snippets' },

    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('snippets')
    end,
  },

  opts = {
    keymap = {
      preset = 'default',
      ['<C-l>'] = { 'snippet_forward', 'fallback' },
      ['<C-h>'] = { 'snippet_backward', 'fallback' },
    },

    snippets = { preset = 'luasnip' },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'normal',
    },

    signature = { enabled = true },

    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      prebuilt_binaries = {
        download = true,
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },

  opts_extend = { 'sources.default' },
}
