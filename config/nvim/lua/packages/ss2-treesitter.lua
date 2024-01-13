-- richer language parsing features
Ss2.useModule({
  name = 'nvim-treesitter.configs',
  required = true,
  configure = function (nvimTreesitter)
    nvimTreesitter.setup({
      ensure_installed = Ss2.isNixUser() and {} or { "lua" },
      auto_install = false,
      highlight = { enable = true }
    })
    -- TODO: use treesitter for folding
  end
})
