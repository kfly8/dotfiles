
-- Ensure lazy.nvim is installed
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

require('lazy').setup({
  { 'itchyny/lightline.vim' },
  { 'junegunn/vim-easy-align', cmd = 'EasyAlign' },

  -- fzf
  { 'ibhagwan/fzf-lua', branch = 'main' },

  -- Completion
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'zbirenbaum/copilot.lua', build = ':Copilot setup' },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },

  { 'junegunn/goyo.vim' },
  { 'wakatime/vim-wakatime' },
  { 'markonm/traces.vim' },

  -- Plugin Language
  { 'vim-perl/vim-perl', ft = 'perl', build = 'make clean carp highlight-all-pragmas moose test-more try-tiny heredoc-sql object-pad' },
  { 'rhysd/vim-gfm-syntax', ft = 'markdown' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'jparise/vim-graphql', ft = 'graphql' },
  { 'ziglang/zig.vim', ft = 'zig' },

  {
    "luckasRanarison/tailwind-tools.nvim",
    build = ":UpdateRemotePlugins",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    ft="tsx"
  },

  -- Color Scheme and extensions
  { 'sainnhe/gruvbox-material' },
  { 'rebelot/kanagawa.nvim' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'norcalli/nvim-colorizer.lua' },
  { 'nvim-tree/nvim-web-devicons' },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" }
  }
})

