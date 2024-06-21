


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
  { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
  { 'junegunn/fzf.vim' },
  { 'yuki-yano/fzf-preview.vim', branch = 'release/remote', build = ':UpdateRemotePlugins' },

  -- Completion
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'github/copilot.vim', build = ':Copilot setup' },

  { 'junegunn/goyo.vim' },
  { 'wakatime/vim-wakatime' },
  { 'markonm/traces.vim' },

  -- Plugin Language
  { 'vim-perl/vim-perl', ft = 'perl', build = 'make clean carp highlight-all-pragmas moose test-more try-tiny heredoc-sql object-pad' },
  { 'kfly8/perl-local-lib-path.vim', ft = 'perl', branch = 'perl-project-root-files' },
  { 'rhysd/vim-gfm-syntax', ft = 'markdown' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'jparise/vim-graphql', ft = 'graphql' },
  { 'ziglang/zig.vim', ft = 'zig' },
  { 'glidenote/memolist.vim' },

  -- Color Scheme and extentions
  { 'sainnhe/gruvbox-material' },
  { 'rebelot/kanagawa.nvim' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'norcalli/nvim-colorizer.lua' },
})

