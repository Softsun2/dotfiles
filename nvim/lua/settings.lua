vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = false 
vim.cmd('set noswapfile')
vim.cmd('filetype plugin indent on')
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 20
vim.opt.foldenable = false
vim.o.termguicolors = true
-- vim.g.undodir = '~/.local/share/nvim/undodir'
-- vim.g.undofile = true



-- treesitter
local ts_configs = require('nvim-treesitter.configs')
ts_configs.setup {
  ensure_installed = 'maintained',
  highlight = { enable = true },
  indent = { enable = true }
}


--[[ Dumb hack to supress lsp server autostart failure notice.
     This message is annoying when jumping to src with an
     unrecognizable root pattern or if your project dir uses multiple
     lsp servers. If there's an issue with an lsp server just
     use ":LspInfo". ]]
-- local notify = vim.notify
-- vim.notify = function(msg, ...)
--   if msg:match("[lspconfig]") then
--     return
--   end
--     notify(msg, ...)
-- end
