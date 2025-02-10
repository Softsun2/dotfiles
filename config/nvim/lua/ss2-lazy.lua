-- declaration of required dependencies

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not Ss2.isNixUser() and not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",  -- latest stable release
        lazypath
    })
end

vim.opt.rtp:append(lazypath)

Ss2.useModule({
    name = "lazy",  -- lazy loading plugin manager
    required = false,
    configure = function (lazy)
        local plugins = {
            { "neovim/nvim-lspconfig", tag = "v0.1.7", lazy = false },
            { "hrsh7th/nvim-cmp", lazy = false },
            { "L3MON4D3/LuaSnip", tag = "v2.1.1", lazy = false },
            { "nvim-treesitter/nvim-treesitter", tag = "v0.9.1", lazy = false },
            -- required by telescope
            { "nvim-lua/plenary.nvim", tag = "v0.1.4", lazy = false },
            { "nvim-telescope/telescope.nvim", tag = "0.1.5", lazy = false },
        }
        local opts = {
            defaults = { lazy = true },
            -- lockfile = should be accesible by version control
            -- do something about them icons
        }
        lazy.setup(plugins, opts)
    end
})
