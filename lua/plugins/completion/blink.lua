return {
  'saghen/blink.cmp',
  enabled = require('nixCatsUtils').enableForCategory({ 'completion', 'blink' }),
  event = 'InsertEnter',
  version = '1.*',

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
