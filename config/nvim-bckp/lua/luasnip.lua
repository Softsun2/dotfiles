local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  -- be able to jump back into snippet even if you move
  -- outside of the section
  history = true,

  -- update as you type, for dynamic snippets
  updateevents = "TextChanged,TextChangedI",

  enable_autosnippets = true;

  -- crazy highlights??
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
}

-- <c-l> for expanding
-- expands the current item or jumps to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-l>", function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <c-h> for jumping backwards within the snippet
-- always jumps to the previous item in the snippet
vim.keymap.set({ "i", "s" }, "<c-h>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- <c-o> for selecting within a list of options
-- useful for choice nodes
vim.keymap.set("i", "<c-o>", function ()
  if ls.choice_actice() then
    ls.change_choice()
  end
end)
