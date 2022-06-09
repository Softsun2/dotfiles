local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-[>'] = actions.preview_scrolling_up,
        ['<C-]>'] = actions.preview_scrolling_down
      }
    },
    -- FIXME: there's probably a string util that simplifies this
    -- strips leading dot slashes from resulting paths
    path_display = function (opts, path)
      if string.sub(path, 1, 2) == "./" then
        return string.sub(path, 3, -1)
      else return path
      end
    end
  }
}
