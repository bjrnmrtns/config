local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- utility lua library
    { "nvim-lua/plenary.nvim" },
    -- searching files and content
    { "nvim-telescope/telescope.nvim" },
    -- color scheme rosepine
    { "rose-pine/neovim",                 name = "rose-pine" },
    -- treesitter
    { "nvim-treesitter/nvim-treesitter" },
    -- harpoon -> marking files to quickly navigate to
    { "ThePrimeagen/harpoon" },
    -- undotree for the best undoing
    { "mbbill/undotree" },
    -- git utility
    { "tpope/vim-fugitive" },

    -- lsp language servers automatic installs
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    -- lsp managed by lsp-zero
    { "VonHeikemen/lsp-zero.nvim",        branch = "v3.x" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "L3MON4D3/LuaSnip" },
})
