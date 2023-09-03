local opt = vim.opt

-- nvim-treesitter
require("nvim-treesitter.configs").setup {
  -- I installed parsers with nix, see home.nix
  -- ensure_installed = { },
  highlight = { enable = true },
}
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
-- if running into invalid node errors:
-- rm -rf ~/.local/share/nvim
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1858
