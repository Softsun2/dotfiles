-- :help index for default keybinds
-- vim.api.nvim_set_keymap({mode}, {keymap}, {mapped to}, {options})
local keymap = vim.api.nvim_set_keymap
local opts = {noremap = true}
local function nkeymap(key, map)
  keymap('n', key, map, opts)
end

vim.g.mapleader = ' ' -- leader key is space

-- conventional save
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})

-- split navigation
keymap('n', '<c-h>', '<c-w>h', opts)
keymap('n', '<c-j>', '<c-w>j', opts)
keymap('n', '<c-k>', '<c-w>k', opts)
keymap('n', '<c-l>', '<c-w>l', opts)

-- consistent Y
nkeymap('Y', 'y$')

-- lsp
nkeymap('gd', ':lua vim.lsp.buf.definition()<CR>')
nkeymap('gD', ':lua vim.lsp.buf.declaration()<CR>')
nkeymap('gi', ':lua vim.lsp.buf.implementation()<CR>')
nkeymap('gw', ':lua vim.lsp.buf.document_symbol()<CR>')
nkeymap('gw', ':lua vim.lsp.buf.workspace_symbol()<CR>')
nkeymap('gr', ':lua vim.lsp.buf.references()<CR>')
nkeymap('gt', ':lua vim.lsp.buf.type_definition()<CR>')
nkeymap('K', ':lua vim.lsp.buf.hover()<CR>')
nkeymap('<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
nkeymap('<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

-- telescope
nkeymap(' f', ':Telescope find_files<CR>')
nkeymap(' g', ':Telescope live_grep<CR>')
nkeymap(' b', ':Telescope buffers<CR>')
nkeymap(' h', ':Telescope help_tags<CR>')
