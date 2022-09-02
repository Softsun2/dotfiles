
local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('fzf_native')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        -- list of actions
        -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
        ['<c-y>'] = actions.select_default,
        ['<c-n>'] = false,
        ['<c-p>'] = false,
      }
    },
  }
}
