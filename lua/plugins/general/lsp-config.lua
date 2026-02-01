return {
  'neovim/nvim-lspconfig',
  enabled = require('nixCatsUtils').enableForCategory({ 'general' }),

  dependencies = {
    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = (nixCats.nixCatsPath or '') .. '/lua', words = { 'nixCats' } },
        },
      },
    },
  },

  init = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('<C-W>d', vim.diagnostic.open_float, 'Diagnostics Float Window')

        map('[d', function()
          vim.diagnostic.jump({ count = -1 })
        end, 'Prev Diagnostic')
        map(']d', function()
          vim.diagnostic.jump({ count = 1 })
        end, 'Next Diagnostic')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client and client:supports_method('textDocument/inlayHint', event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

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

    -- Keymap to toggle virtual_lines
    vim.keymap.set('n', '<leader>vl', function()
      local current = vim.diagnostic.config().virtual_lines
      vim.diagnostic.config({
        virtual_lines = not current,
      })
    end, { desc = 'Toggle [V]irtual [L]ines' })

    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

    vim.lsp.enable({
      'bashls',
      'texlab',
      'clangd',
      'gopls',
      'lua_ls',
      'neocmake',
      'nixd',
      'pyright',
      'rust_analyzer',
      'ts_ls',
      'tinymist',
      'jdtls',
    })

    -- Special Lua Config, as recommended by neovim help docs
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath('config')
            and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })
  end,
}
