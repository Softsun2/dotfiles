local opt = vim.opt
local wo = vim.wo
local g = vim.g
local o = vim.o

-- Ui
wo.number = true                -- line numbers
wo.relativenumber = true        -- relative line numbers
wo.wrap = false                 -- no wrap
o.termguicolors = false         -- use terminal colors
opt.cursorline = true
opt.colorcolumn = "80"

-- History
opt.swapfile = false
opt.undofile = true
opt.undodir = "/home/softsun2/.cache/"

-- Indentation
opt.autoindent = true           -- copy current indent level when starting a new line
opt.tabstop = 2                 -- number of spaces a tab when tabbing
opt.shiftwidth = 2              -- denotes width of a level of indentation
opt.expandtab = true            -- tab with spaces

-- folding
opt.foldenable = false          -- open all folds upon entering a file

-- splitting
o.splitright = true
o.splitbelow = true

-- Misc
opt.ignorecase = true           -- ignore case when searching
opt.smartcase = true            -- only ignore case if all lowercase
opt.autoread = true             -- reread file if external changes are made to such file
opt.incsearch = true            -- on by default, make sure it's on, search matches what's been typed so far

-- DISABLE OMNI SQL KEYMAPS HOLY FUCK IS THIS ANNOYING
g.omni_sql_no_default_maps = 1
