-- Lsp configuratons:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md


local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Note: nvim-navic can attach to only one server per buffer.
local navic = require("nvim-navic")
local navic_on_attach = function (client, bufnr)
  navic.attach(client, bufnr)
end

-- There is certainly a design for better implementing the my desired
-- defaults per lsp config. Another time...

-- spelling/grammer
lspconfig.ltex.setup {
  on_attach = navic_on_attach,
  capabilities = capabilities,
}

-- nix
lspconfig.rnix.setup {
  on_attach = navic_on_attach,
  capabilities = capabilities,
}


-- lua
lspconfig.lua_ls.setup {
  on_attach = navic_on_attach,
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
lspconfig.ccls.setup {
  on_attach = navic_on_attach,
  capabilities = capabilities,
}


-- python
lspconfig.pyright.setup {
  on_attach = navic_on_attach,
  capabilities = capabilities,
}


-- html
lspconfig.html.setup {
  on_attach = navic.on_attach,
  capabilities = capabilities,
}


-- css
lspconfig.cssls.setup {
  on_attach = navic.on_attach,
  capabilities = capabilities,
}


-- js/ts
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
lspconfig.tsserver.setup {
  on_attach = navic.on_attach,
  capabilities = capabilities,
}
-- js/ts linting
lspconfig.eslint.setup {
  on_attach = navic.on_attach,
  capabilities = capabilities,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
    format = true,
  }
}

-- ocaml
lspconfig.ocamllsp.setup {
  on_attach = navic.on_attach,
  capabilities = capabilities,
}


-- R
lspconfig.r_language_server.setup {
  on_attach = navic.on_attach,
  capabilities = capabilities,
}
