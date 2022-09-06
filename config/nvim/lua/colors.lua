local o = vim.opt

-- Use or don't use terminal colors, depends on theme
o.termguicolors = false

-- disable dianostic column bg
vim.cmd('hi SignColumn ctermbg=NONE')

-- bold & underline status line for active pane
vim.cmd('hi StatusLine cterm=bold,underline')

-- disable status line for inactive panes
vim.cmd('hi StatusLineNC cterm=NONE')

-- disable inverse vertsplit bar bg
vim.cmd('hi VertSplit cterm=NONE')

-- disable folded indicator bg
vim.cmd('hi Folded ctermbg=NONE')

-- disable line number column bg
vim.cmd('hi LineNr ctermbg=NONE')

-- set minimal cursor line
vim.cmd('hi CursorLine ctermfg=NONE cterm=underline guibg=NONE')

-- set indent line color
-- vim.cmd('hi IndentBlankLineChar cterm=bold ctermfg=236')

-- disable end of buffer tildas
if o.termguicolors then
  vim.cmd('hi EndOfBuffer gui=NONE')
end

-- disable match paren bg
vim.cmd('hi MatchParen ctermbg=NONE')

-- set NonText characters to a less noticable color
vim.cmd('hi NonText ctermfg=DarkGrey')
