local function getHiGuiAttr(group, attr)
  return vim.fn.synIDattr(vim.fn.hlID(group), attr, "cterm")
end

vim.cmd('hi SignColumn ctermbg=NONE')
vim.cmd('hi StatusLineNC cterm=NONE')
vim.cmd('hi StatusLine cterm=bold,underline')
vim.cmd('hi VertSplit cterm=NONE')
vim.cmd('hi Folded ctermbg=NONE')
vim.cmd('hi Pmenu ctermbg=NONE')

-- cmp suggestion colors
local cmpItemAbbr =  -- color of unfinished portion of suggestion
  string.format("hi CmpItemAbbr ctermfg=%s", getHiGuiAttr("Comment", "fg"))
local cmpItemAbbrDeprecated =  -- color of deprecated suggestions
  string.format("hi CmpItemAbbrDeprecated ctermfg=%s", getHiGuiAttr("ErrorMsg", "fg"))
local cmpItemAbbrMatchFuzzy =  -- color of characters used in fuzzy suggestion
  string.format("hi CmpItemAbbrMatchFuzzy cterm=italic,bold ctermfg=%s", getHiGuiAttr("Comment", "fg"))
local cmpItemKind =  -- color of kind of suggestion
  string.format("hi CmpItemKind ctermfg=%s", getHiGuiAttr("Special", "fg"))
local cmpItemMenu =  -- color of suggestion source
  string.format("hi CmpItemAbbr ctermfg=%s", getHiGuiAttr("NonText", "fg"))

vim.cmd(cmpItemAbbr)
vim.cmd(cmpItemAbbrDeprecated)
vim.cmd(cmpItemAbbrMatchFuzzy)
vim.cmd(cmpItemKind)
vim.cmd(cmpItemMenu)

