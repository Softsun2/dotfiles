local cmp = require("cmp")
local function contextIsComment()
  return
    require"cmp.config.context".in_treesitter_capture("comment")==true or
    require"cmp.config.context".in_syntax_group("Comment")
end


cmp.setup {

  enabled = function ()
    return not contextIsComment()
  end,

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },

  formatting = {
    format = require("lspkind").cmp_format {
      with_text = true,
      menu = {
        luasnip = "[snip]",
        buffer = "[buf]",
        nvim_lua = "[api]",
        nvim_lsp = "[LSP]",
        path = "[path]",
      },
    },
  },

  mapping = {
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-2),
    ["<C-f>"] = cmp.mapping.scroll_docs(2),
    ["<C-o>"] = cmp.mapping.complete(),           -- have literally no idea whtat this does lmao
    ["<C-y>"] = cmp.mapping.confirm { select = true },
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }
  },

  sources = cmp.config.sources {
    { name = "nvim_lua", keyword_length = 2 },
    { name = "nvim_lsp", keyword_length = 2 },
    { name = "luasnip", keyword_length = 2 },
    { name = "buffer", keyword_length = 4 },
    { name = "path", keyword_length = 2 },
  },

  experimental = {
    ghost_text = true,
  },

}

-- don't see a need for this yet
-- completions for searches
-- cmp.setup.cmdline("/", {
--   sources = cmp.config.sources {
--     { name = "buffer" },
--   },
-- })

-- completions for vimcmds
-- cmp.setup.cmdline(":", {
--   sources = cmp.config.sources {
--     { name = "path" },
--     { name = "cmdline" },
--   },
-- })

-- Make sure to add completion capabilities to lspconfig!
