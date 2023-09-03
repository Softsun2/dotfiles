local function source(src)
  dofile(
    '/Users/softsun2/.dotfiles/config/nvim/lua/' ..
    src ..
    '.lua'
  )
end

source('settings')          -- TODO: this must be sourced before colors
source('keymaps')
source('lsp')
source('luasnip')
source('completion')
source('telescope')
source('treesitter')
source('colors')
source('indent-blankline')
source('nvim-tree')

-- todo
--
-- require lua files, don't use a vim cmd
-- lsp diagnostic interaction/code actions
-- mv plugin settings to their own files
-- mv all keymaps to keymaps.lua
