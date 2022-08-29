-- ~/.dotfiles/home.nix for installed lsps
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())


-- nix
lspconfig.rnix.setup {
  capabilities = capabilities,
}


-- lua
lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}


-- c


-- cpp


-- python


-- html ?


-- css ?


-- js
