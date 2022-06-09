local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- sumneko_lua
require'lspconfig'.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim', 'use'}
      },
    }
  }
}

-- clangd
-- lspconfig.clangd.setup {
--   capabilities = capabilities
-- }

-- pylsp
-- lspconfig.pylsp.setup {
--   capabilities = capabilities,
--   settings = {
--     pylsp = {
--       plugins = {
--         jedi_completion = {
--           enabled = true,
--           include_params = true
--         },
--         pycodestyle = {
--           enabled = false,
--         },
--       },
--     },
--   },
-- }
