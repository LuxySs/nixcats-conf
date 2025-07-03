return {
  'nvim-treesitter/nvim-treesitter',
  enabled = require('nixCatsUtils').enableForCategory 'treesitter',

  event = 'VeryLazy',
  lazy = false,

  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  build = require('nixCatsUtils').lazyAdd ':TSUpdate',

  opts = {
    -- NOTE: nixCats: use lazyAdd to only set these 2 options if nix wasnt involved.
    -- because nix already ensured they were installed.
    ensure_installed = require('nixCatsUtils').lazyAdd { 'bash', 'c', 'cpp', 'lua', 'markdown', 'python', 'rust' },
    auto_install = require('nixCatsUtils').lazyAdd(true, false),
    ignore_install = { 'latex' }, -- because I use vimtex instead

    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
      disable = { 'latex', 'ruby' },
    },

    indent = { enable = true, disable = { 'ruby' } },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<M-o>', -- set to `false` to disable one of the mappings
        node_incremental = '<M-o>',
        scope_incremental = '<M-O>',
        node_decremental = '<M-i>',
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,

        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['as'] = '@scope',
        },
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        include_surrounding_whitespace = true,
      },
    },
  },

  config = function(_, opts)
    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
  end,
}
