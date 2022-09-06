-- source all configurations from one file
NvimLuaConfigPrefix = '~/.dotfiles/config/nvim/lua/'

-- sources a file in this dir
local function source(src)
  vim.cmd('source ' .. NvimLuaConfigPrefix .. src)
end

source('settings.lua')
source('keymaps.lua')
source('lsp.lua')
source('luasnip.lua')
source('completion.lua')
source('plugins.lua')
source('telescope.lua')
source('colors.lua')

-- todo
--
-- require lua files, don't use a vim cmd
-- harpoon
-- lsp diagnostic interaction/code actions
-- mv plugin settings to their own files
-- mv all keymaps to keymaps.lua
-- lsp saga
-- autopairs
-- git indicators
-- highlight devicons nicely
