----------------------------------------------------------------
-- Plugin
----------------------------------------------------------------

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
  'itchyny/lightline.vim',
  { 'junegunn/vim-easy-align', cmd = 'EasyAlign' },

  -- fzf
  { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
  'junegunn/fzf.vim',
  { 'yuki-yano/fzf-preview.vim', branch = 'release/remote', build = ':UpdateRemotePlugins' },

  -- Completion
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  { 'github/copilot.vim', build = ':Copilot setup' },

  'junegunn/goyo.vim',
  'wakatime/vim-wakatime',
  'markonm/traces.vim',

  -- Plugin Language
  { 'vim-perl/vim-perl', ft = 'perl', build = 'make clean carp highlight-all-pragmas moose test-more try-tiny heredoc-sql object-pad' },
  { 'kfly8/perl-local-lib-path.vim', ft = 'perl', branch = 'perl-project-root-files' },
  { 'rhysd/vim-gfm-syntax', ft = 'markdown' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'jparise/vim-graphql', ft = 'graphql' },
  { 'ziglang/zig.vim', ft = 'zig' },

  -- Color Scheme and extentions
  'sainnhe/gruvbox-material',
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }
})

----------------------------------------------------------------
-- Filetypes
----------------------------------------------------------------

vim.filetype.add({
  extension = {
    psgi = 'perl',
    t = 'perl',
    tx = 'html',
  }
})

----------------------------------------------------------------
-- Common
----------------------------------------------------------------

vim.g.mapleader = ' '

vim.o.number = true
vim.o.list = true
vim.o.listchars = 'tab:»-,trail:~,eol:↲,extends:»,precedes:«,nbsp:%'
vim.o.showtabline = 2
vim.o.signcolumn = 'yes'

function ZenkakuSpace()
  vim.cmd [[hi ZenkakuSpace cterm=reverse ctermfg=darkgrey gui=reverse guifg=darkgrey]]
end

if vim.fn.has('syntax') then
  vim.api.nvim_create_augroup('ZenkakuSpace', {clear = true})
  vim.api.nvim_create_autocmd('ColorScheme', {group = 'ZenkakuSpace', callback = ZenkakuSpace})
  vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter'}, {group = 'ZenkakuSpace', pattern = '*', command = 'match ZenkakuSpace /　/'})
  ZenkakuSpace()
end

vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd [[colorscheme gruvbox-material]]

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

----------------------------------------------------------------
-- Plugin Config
----------------------------------------------------------------

-- fzf --
vim.api.nvim_set_keymap('n', '<leader><leader>', ':GFiles<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':Lines<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>c', ':Commands<CR>', {noremap = true, silent = true})

-- Goyo --
vim.g.goyo_width = 80

-- LSP --
local lspconfig = require('lspconfig')
lspconfig.perlnavigator.setup{}
lspconfig.tsserver.setup{}
lspconfig.efm.setup{
  filetypes = { 'graphql', 'markdown' },
}

vim.keymap.set('n', '<C-k>',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ['<Esc>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- lightline --
vim.g.lightline = {
  active = {
    left = { {'mode', 'paste'}, {'readonly', 'relativepath', 'modified'} },
  },
  tab_component_function = {
    filename = 'LightlineTabFilename'
  }
}

-- Vimのタブ名が、index.tsxだけで見づらかったので、直親ディレクトリ名も表示する
-- Ref: https://zenn.dev/kfly8/scraps/2b97b46ca25fbe
function LightlineTabFilename(n)
  local bufnr = vim.fn.tabpagebuflist(n)[vim.fn.tabpagewinnr(n) - 1]
  local filepath = vim.fn.expand('#' .. bufnr .. ':p')

  local parent = vim.fn.fnamemodify(vim.fn.fnamemodify(filepath, ':h'), ':t')
  local name = vim.fn.fnamemodify(filepath, ':t')
  local tab_filename = parent .. '/' .. name

  return (tab_filename ~= '' and tab_filename or '[No Name]')
end
