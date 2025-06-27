-- enable nvim tree
require("nvim-tree").setup {
  git = {
    enable = false    -- git component creates significant lag
  }
}
