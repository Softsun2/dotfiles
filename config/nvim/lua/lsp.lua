-- ~/.dotfiles/home.nix for installed lsps
local lspconfig = require("lspconfig")


-- nix
lspconfig.rnix.setup {}


-- lua
lspconfig.sumneko_lua.setup {
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

