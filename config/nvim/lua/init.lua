local function source(src)
  dofile(
    '/home/softsun2/.dotfiles/config/nvim/lua/' ..
    src ..
    '.lua'
  )
end

source('settings')          -- TODO: this must be sourced before colors
source('keymaps')
-- source('navic')
source('lsp')
source('luasnip')
source('completion')
source('telescope')
-- source('indent-blankline')
-- source('nvim-tree')
-- source('lspsaga')
source('treesitter')
-- source('autopairs')
-- source('illuminate')
-- source('gitsigns')
-- source('lualine')
-- source('zen-mode')

-- todo
--
-- require lua files, don't use a vim cmd
-- lsp diagnostic interaction/code actions
-- filter out annoying lsp diagnostics
-- what to the lspsaga lightbulbs mean?
-- don't display diagnostic messages, only when jumping to them
-- mv plugin settings to their own files
-- mv all keymaps to keymaps.lua
-- buggy indent line
-- disable comletions in telescope/vin cmds
-- floating window highlight groups are messed up
-- 80 char highlight col
-- size windows to 80 col width
