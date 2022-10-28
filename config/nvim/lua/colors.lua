
-- base16 colors
-- Start flavours
require('base16-colorscheme').setup({
    base00 = '#272822', base01 = '#383830', base02 = '#49483e', base03 = '#75715e',
    base04 = '#a59f85', base05 = '#f8f8f2', base06 = '#f5f4f1', base07 = '#f9f8f5',
    base08 = '#f92672', base09 = '#fd971f', base0A = '#f4bf75', base0B = '#a6e22e',
    base0C = '#a1efe4', base0D = '#66d9ef', base0E = '#ae81ff', base0F = '#cc6633',
})
-- End flavours

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
vim.cmd('hi CursorLine ctermfg=NONE cterm=bold,underline ctermbg=NONE guifg=NONE gui=bold,underline guibg=NONE')

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
