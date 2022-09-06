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

-- comfy move to top/bottom
nkeymap('zt', 'ztkkk3j')
nkeymap('zb', 'zbjjj3k')

-- telescope
nkeymap( '<leader>f', ":Telescope find_files<cr>")
nkeymap( '<leader>t', ":Telescope live_grep<cr>")
nkeymap( 'gd', ":Telescope lsp_definitions<cr>")
-- goto references
