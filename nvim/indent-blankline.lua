local opt = vim.opt

-- extend charset
opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"
opt.listchars:append "trail:⌢"

-- enable indent-blankline
require("indent_blankline").setup {
  show_end_of_line = true,
  space_char_blankline = " ",
}

