Ss2 = require("ss2-lib")

-- dependency-less configuration
Ss2.safeLoadModule("ss2-settings")      -- neovim options
Ss2.safeLoadModule("ss2-keybinds")      -- global keymaps
Ss2.safeLoadModule("ss2-colors")        -- neovim colorscheme

-- Ss2.safeLoadModule("ss2-lazy")          -- package manager
Ss2.safeLoadModule("ss2-lsp")           -- lsp
Ss2.safeLoadModule("ss2-package")       -- packages

-- todo
-- lsp diagnostic interaction/code actions
-- filter out annoying lsp diagnostics
-- what do the lspsaga lightbulbs mean?
-- don't display diagnostic messages, only when jumping to them
-- mv plugin settings to their own files
-- mv all keymaps to keymaps.lua
-- buggy indent line
-- disable completions in telescope/vin cmds
-- floating window highlight groups are messed up
-- size windows to 80 col width
