-- source all configurations from one file

-- sources a file in this dir
local function source(src)
  vim.cmd('source ' .. src)
end

source('settings.lua')
source('keybinds.lua')
source('lsp.lua')
source('luasnip.lua')
source('completion.lua')
source('plugins.lua')
source('colors.lua')

