-- source all configurations from one file
nvimLuaConfigPrefix = '~/.dotfiles/config/nvim/lua/'

-- sources a file in this dir
local function source(src)
  vim.cmd('source ' .. nvimLuaConfigPrefix .. src)
end

source('settings.lua')
source('keybinds.lua')
source('lsp.lua')
source('luasnip.lua')
source('completion.lua')
source('plugins.lua')
source('colors.lua')

