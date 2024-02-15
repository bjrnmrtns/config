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
  -- descriptions of keys pressed
  'folke/which-key.nvim',

  -- specific colorscheme
  'folke/tokyonight.nvim',

  -- lua library needed for at least telescope
  'nvim-lua/plenary.nvim',

  -- searching files and content
  'nvim-telescope/telescope.nvim',

  -- syntax highlighting
  'kyazdani42/nvim-tree.lua',

  -- language server protocol config
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp', 

  -- treesitter syntax highlighting
  'nvim-treesitter/nvim-treesitter',
})

-- # options
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect", "noinsert" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeout = true
vim.opt.timeoutlen = 300                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = false                  -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications

vim.opt.shortmess:append "c"

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])


-- # key mappings
function keymap(mode, lhs, rhs, new_opts)
  -- Default keymappings silent = true -> the command is not shown in status bar
  -- remap = true -> recursively remap keys
  local default_opts = { remap = true, silent = true }
  local merged_opts = vim.tbl_deep_extend('force', default_opts, new_opts)
  vim.keymap.set(mode, lhs, rhs, merged_opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("", "<Space>", "<Nop>", {})

-- viewing a keymapping is done using: :verbose map <keymapping>
keymap("n", "<C-h>", "<C-w>h", {})
keymap("n", "<C-j>", "<C-w>j", {})
keymap("n", "<C-k>", "<C-w>k", {})
keymap("n", "<C-l>", "<C-w>l", {})

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>",  {})
keymap("n", "<C-Down>", ":resize +2<CR>",  {})
keymap("n", "<C-Left>", ":vertical resize -2<CR>", {})
keymap("n", "<C-Right>", ":vertical resize +2<CR>", {})

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { desc = "buf navigate left" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "buf navigate right" })

-- Telescope search
keymap("n", "<leader>ff", ":Telescope find_files<cr>", { desc = "telescope find_files" })
keymap("n", "<leader>fg", ":Telescope live_grep<cr>", { desc = "telescope live_grep" })
keymap("n", "<leader>fb", ":Telescope buffers<cr>", { desc = "telescope buffers" })
keymap("n", "<leader>fh", ":Telescope help_tags<cr>", { desc = "telescope help_tags" })

-- NvimTree
keymap("", "<leader>e", ":NvimTreeToggle<cr>", { desc = "nvim tree" })

-- Overseer
keymap("", "<leader>rr", ":OverseerRun<cr>", { desc = "Overseer run" })

-- lsp specific keymappings
local on_attach = function(client, bufnr)
    vim.g.completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']"

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {})
    keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
    keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', {})
    keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {})
    keymap('n', '<leader>,', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {})
    keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', {})
    keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', {})
    keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', {})
    keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {})
    keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {})
    keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {})
    keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {})
    keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', {})
    keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {})
    keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {})
    keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {})
    keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', {})
end


-- # Setup colorscheme
vim.cmd[[colorscheme tokyonight]]


-- # Setup which-key
require("which-key").setup {}

-- # Setup Nvimtree
require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        git = true,
	file = false,
	folder = false,
	folder_arrow = true,
      },
      glyphs = {
        folder = {
          arrow_closed = "⏵",
          arrow_open = "⏷",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "⌥",
          renamed = "➜",
          untracked = "★",
          deleted = "⊖",
          ignored = "◌",
        },
      },
    },
  },
})

-- # Setup cmp

local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
--    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


-- # Setup lsp with cmp pyright python
require("lspconfig").pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- # Setup lsp with cmp clangd c / c++
require("lspconfig").clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- # Setup lsp with cmp rust-analyzer rust
require("lspconfig").rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- # Setup lsp with cmp tsserver typescript
require("lspconfig").tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- # Setup nvim treesitter
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "python", "lua", "typescript", "markdown" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
