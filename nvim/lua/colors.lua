local function getHiGuiAttr(group, attr)
  return vim.fn.synIDattr(vim.fn.hlID(group), attr, "gui")
end


-- Start flavours
-- local base16 = require('base16')
-- local theme = base16.theme_from_array {
--   "1C1E26"; "232530"; "2E303E"; "6F6F70";
--   "9DA0A2"; "CBCED0"; "DCDFE4"; "E3E6EE";
--   "E93C58"; "E58D7D"; "EFB993"; "EFAF8E";
--   "24A8B4"; "DF5273"; "B072D1"; "E4A382"
-- }
-- base16(theme, true)
-- End flavours


-- basic colors
vim.cmd('hi LineNr guibg=NONE')
vim.cmd('hi SignColumn guibg=NONE')
vim.cmd('hi StatusLine guibg=NONE')
vim.cmd('hi VertSplit guibg=NONE')
vim.cmd('hi Folded guibg=NONE')
vim.cmd('hi EndOfBuffer guifg=bg')


-- cmp suggestion colors
-- local cmpItemAbbr =  -- color of unfinished portion of suggestion
--   string.format("hi CmpItemAbbr guifg=%s", getHiGuiAttr("Comment", "fg"))
-- local cmpItemAbbrDeprecated =  -- color of deprecated suggestions
--   string.format("hi CmpItemAbbrDeprecated guifg=%s", getHiGuiAttr("ErrorMsg", "fg"))
-- local cmpItemAbbrMatchFuzzy =  -- color of characters used in fuzzy suggestion
--   string.format("hi CmpItemAbbrMatchFuzzy gui=italic,bold guifg=%s", getHiGuiAttr("Comment", "fg"))
-- local cmpItemKind =  -- color of kind of suggestion
--   string.format("hi CmpItemKind guifg=%s", getHiGuiAttr("Special", "fg"))
-- local cmpItemMenu =  -- color of suggestion source
--   string.format("hi CmpItemAbbr guifg=%s", getHiGuiAttr("NonText", "fg"))

-- vim.cmd(cmpItemAbbr)
-- vim.cmd(cmpItemAbbrDeprecated)
-- vim.cmd(cmpItemAbbrMatchFuzzy)
-- vim.cmd(cmpItemKind)
-- vim.cmd(cmpItemMenu)
