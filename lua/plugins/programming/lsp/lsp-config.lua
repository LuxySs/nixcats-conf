return {
  'neovim/nvim-lspconfig',
  enabled = require('nixCatsUtils').enableForCategory { 'programming', 'lsp' },
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
          -- adds type hints for nixCats global
          { path = require('nixCats').nixCatsPath .. '/lua', words = { 'nixCats' } },
        },
      },
    },
  },

  opts = {
    servers = {
      bashls = {},
      clangd = {},
      gopls = {},
      neocmake = {},
      pyright = {},
      rust_analyzer = {
        settings = {
          rust_analyzer = {
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
            autoImportCompletions = false,
            reportMissingImports = true,
            followImportForHints = true,

            cargo = {
              allFeatures = true,
            },
          },
        },
      },
      ts_ls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              globals = { 'nixCats' },
              disable = { 'missing-fields' },
            },
          },
        },
      },
      nixd = {},
    },
  },

  config = function(_, opts)
    local lspconfig = require 'lspconfig'

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        map('K', vim.lsp.buf.hover, 'Hover Documentation')

        map('[d', vim.diagnostic.goto_prev, 'Prev Diagnostic')
        map(']d', vim.diagnostic.goto_next, 'Next Diagnostic')

        map('<C-W>d', vim.diagnostic.open_float, 'Diagnostics Float Window')

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Keymap to toggle inlay hints in your code, if supported by the lsp.
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    for server, config in pairs(opts.servers) do
      lspconfig[server].setup(config)
    end
  end,
}
