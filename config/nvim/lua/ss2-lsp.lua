-- language server configurations
Ss2.useModule({
    name = "lspconfig",
    required = true,
    configure = function(lspconfig)
        --Supports overloads for an lsp client. Can be provided as a
        --callback for clients for languages that support function overloading.
        local supportLspOverloads = function(client, _)
            if client.server_capabilities.signatureHelpProvider then
                Ss2.safeLoadModule("lsp-overloads").setup(client, {
                    ui = { border = "single" },
                    display_automatically = false,
                })
            end
        end

        -- configure with neovim in mind
        lspconfig.lua_ls.setup({
            on_attach = supportLspOverloads,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME }
                    },
                    telemetry = { enable = false }
                }
            }
        })
        lspconfig.rnix.setup({})
        lspconfig.hls.setup({
            cmd = { "haskell-language-server-wrapper", "--lsp", "-l", "/tmp/hls.out" },
            on_attach = supportLspOverloads,
            settings = {
                haskell = {
                    formattingProvider = "floskell"
                }
            }
        })
        lspconfig.ccls.setup({
            on_attach = supportLspOverloads,
            init_options = {
                index = { threads = 0 },
            }
        })
        -- lspconfig.clangd.setup({ on_attach = supportLspOverloads })

        -- configure lsp ui
        Ss2.safeLoadModule('lspconfig.ui.windows').default_options = {
            border = "single"
        }
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "single", }
        )
        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "single" }
        )

        -- disable diagnostic noise
        vim.diagnostic.config({ virtual_text = false })

        -- odd workaround w/r to https://github.com/Issafalcon/lsp-overloads.nvim/issues/35
        vim.keymap.set("n", "<C-k>", function()
            pcall(vim.cmd, "LspOverloadsSignature")
        end, { noremap = true, silent = true })
        vim.keymap.set("i", "<C-k>", function()
            pcall(vim.cmd, "LspOverloadsSignature")
        end, { noremap = true, silent = true })

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Buffer local mappings.
                local opts = { buffer = ev.buf, noremap = true }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.incoming_calls, opts)
                vim.keymap.set('n', '<leader>e', function()
                    vim.diagnostic.open_float({ border = "single" })
                end, opts)
                vim.keymap.set('n', '<leader>qe', vim.diagnostic.setqflist, opts)
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            end,
        })
    end
})

-- completion engine
Ss2.useModule({
    name = "cmp",
    required = true,
    configure = function(cmp)
        cmp.setup({
            snippet = {
                expand = function(args)
                    Ss2.safeLoadModule("luasnip").lsp_expand(args.body)
                end
            },
            -- TODO: make this vs-like
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
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(2),
                ["<C-u>"] = cmp.mapping.scroll_docs(-2),
                ["<C-h>"] = cmp.mapping.confirm({ select = true }), -- <3
                ["<C-g>"] = cmp.mapping({
                    i = cmp.mapping.abort(),                        -- insert mode
                    c = cmp.mapping.close(),                        -- command mode
                })
            }),
            window = {
                completion = { scrollbar = true },
            },
            -- TODO: dynamic keyword_lengths
            sources = cmp.config.sources({
                {
                    name = "nvim_lsp",
                    keyword_length = 3,
                    entry_filter =
                    -- don't suggest buffer text or snippet completions
                        function(entry, _)
                            local kind = Ss2.safeLoadModule("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
                            return kind ~= "Text" and kind ~= "Snippet"
                        end
                },
                { name = "path", keyword_length = 3 },
            }, {
                { name = "nvim_lua", keyword_length = 3 }
            }),
            experimental = { ghost_text = true }
        })
    end
})
