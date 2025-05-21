vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Initialize packer
vim.o.packpath = vim.o.packpath .. ',~/.local/share/nvim/site'
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- Add your plugins here
    use 'wbthomason/packer.nvim' -- Packer manages itself
    use 'neovim/nvim-lspconfig' -- LSP configurations
    use 'jose-elias-alvarez/null-ls.nvim' -- Formatter setup
    -- Add other plugins as needed
end)
local null_ls = require('null-ls')

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.clang_format
    },
})
vim.opt.clipboard = "unnamed"
vim.o.guifont = "FiraCode:h14"

