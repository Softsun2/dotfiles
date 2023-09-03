local o = vim.opt

-- Use or don't use terminal colors, depends on theme
o.termguicolors = false

-- disable dianostic column bg
vim.cmd('hi SignColumn ctermbg=NONE guibg=NONE')

-- bold & underline status line for active pane
vim.cmd('hi StatusLine cterm=bold,underline gui=bold,underline')

-- disable status line for inactive panes
vim.cmd('hi StatusLineNC cterm=NONE gui=NONE')

-- disable inverse vertsplit bar bg
vim.cmd('hi VertSplit cterm=NONE gui=NONE')

-- disable folded indicator bg
vim.cmd('hi Folded ctermbg=NONE guibg=NONE')

-- disable line number column bg
vim.cmd('hi LineNr ctermbg=NONE guibg=NONE')

-- set minimal cursor line
vim.cmd('hi CursorLine ctermfg=NONE cterm=bold,underline guifg=NONE gui=bold,underline')

-- disable end of buffer tildas
vim.cmd('hi clear EndOfBuffer')
-- vim.cmd('hi link EndOfBuffer ColorColumn')

-- disable match paren bg
vim.cmd('hi MatchParen ctermbg=NONE guibg=NONE')

-- set NonText characters to a less noticable color
vim.cmd('hi NonText ctermfg=DarkGrey')

-- set indent line color
vim.cmd('hi clear IndentBlankLineChar')
vim.cmd('hi link IndentBlankLineChar NonText')

-- Comment
vim.cmd('hi clear Comment')
vim.cmd('hi link Comment LineNr')

-- Special
vim.cmd('hi clear Special')

-- Pmenu (popup menu)
-- vim.cmd('hi clear Pmenu')
-- vim.cmd('hi link Pmenu CursorLineFold')
