-- :help index (for default keybinds)
-- vim.api.nvim_set_keymap({mode}, {keymap}, {mapped_to}, {options})

local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true}
local function nkeymap(key, map)
  keymap('n', key, map, opts)
end

-- leader key: space
vim.g.mapleader = ' '

-- source nvim config
nkeymap('<leader><leader>s', '<cmd>source ~/.dotfiles/config/nvim/lua/init.lua<CR>')

-- split navigation
nkeymap('<c-h>', '<c-w>h')
nkeymap('<c-j>', '<c-w>j')
nkeymap('<c-k>', '<c-w>k')
nkeymap('<c-l>', '<c-w>l')

-- don't yank with x
nkeymap('x', '"_x')

-- better n/N
nkeymap('n', 'nzz')
nkeymap('N', 'Nzz')

-- comfy move to top/bottom
nkeymap('zt', 'ztkkk3j')
nkeymap('zb', 'zbjjj3k')

-- telescope
nkeymap('<leader>f', ":Telescope find_files<cr>")
nkeymap('<leader>t', ":Telescope live_grep<cr>")
nkeymap( 'gd', ":Telescope lsp_definitions<cr>zz")
-- goto references

-- harpoon
nkeymap('<leader>h', ":lua require('harpoon.ui').toggle_quick_menu()<cr>")
nkeymap('<leader>m', ":lua require('harpoon.mark').add_file()<cr>")
-- I'm sure there's a better way of doing this lol
nkeymap('<leader>1', ":lua require('harpoon.ui').nav_file(1)<cr>")
nkeymap('<leader>2', ":lua require('harpoon.ui').nav_file(2)<cr>")
nkeymap('<leader>3', ":lua require('harpoon.ui').nav_file(3)<cr>")
nkeymap('<leader>4', ":lua require('harpoon.ui').nav_file(4)<cr>")
nkeymap('<leader>5', ":lua require('harpoon.ui').nav_file(5)<cr>")

-- splits 
nkeymap('<leader>x', ":split<cr>")
nkeymap('<leader>v', ":vsplit<cr>")
