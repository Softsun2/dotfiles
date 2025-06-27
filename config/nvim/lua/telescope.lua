
local telescope = require('telescope')
local actions = require('telescope.actions')

-- Not recognizing extension for some reason
-- telescope.load_extension('fzf_native')

telescope.setup {
  defaults = {
    path_display = { 'smart' },
    mappings = {
      i = {
        -- list of actions
        -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
        ['<c-y>'] = actions.select_default,
        ['<c-u>'] = actions.preview_scrolling_up,
        ['<c-d>'] = actions.preview_scrolling_down,
        ['<c-n>'] = false,
        ['<c-p>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      -- previewer = 'vim_buffer_cat.new',
      layout_config = {
        height = 9,
      },
    },
    live_grep = {
      theme = 'dropdown',
      -- previewer = false,
      layout_config = {
        height = 9,
      },
    },
  },
}
