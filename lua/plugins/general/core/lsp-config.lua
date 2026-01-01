return {
  'neovim/nvim-lspconfig',
  enabled = require('nixCatsUtils').enableForCategory({ 'core' }),

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

        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        map('[d', function()
          vim.diagnostic.jump({ count = -1 })
        end, 'Prev Diagnostic')
        map(']d', function()
          vim.diagnostic.jump({ count = 1 })
        end, 'Next Diagnostic')

        map('<C-W>d', vim.diagnostic.open_float, 'Diagnostics Float Window')

        map('grn', vim.lsp.buf.rename, 'Rename')

        map('gra', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has('nvim-0.11') == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Keymap to toggle inlay hints in your code, if supported by the lsp.
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
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
    })
  end,
}
