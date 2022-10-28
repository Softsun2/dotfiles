-- Lsp configuratons:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md


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

-- c/cpp
lspconfig.ccls.setup {
  capabilities = capabilities,
}

-- python
lspconfig.pyright.setup {
  capabilities = capabilities,
}


-- html
lspconfig.html.setup {
  capabilities = capabilities,
}

-- css
lspconfig.cssls.setup {
  capabilities = capabilities,
}

-- js/ts
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
lspconfig.tsserver.setup {
  capabilities = capabilities,
}

-- ocaml
lspconfig.ocamllsp.setup {
  capabilities = capabilities,
}

