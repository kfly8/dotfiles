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

  'Yggdroot/indentLine',

  'cappyzawa/trim.nvim',

  -- fzf
  { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
  'junegunn/fzf.vim',
  { 'yuki-yano/fzf-preview.vim', branch = 'release/remote', build = ':UpdateRemotePlugins' },

  -- Completion
  { 'neoclide/coc.nvim', branch = 'release' },
  { 'github/copilot.vim', build = ':Copilot setup' },
  { 'UltiRequiem/coc-zig', build = 'yarn install --frozen-lockfile' },
  'nvimdev/lspsaga.nvim',

  'junegunn/goyo.vim',
  'wakatime/vim-wakatime',
  'markonm/traces.vim',

  -- Plugin Language
  { 'vim-perl/vim-perl', ft = 'perl', build = 'make clean carp highlight-all-pragmas moose test-more try-tiny heredoc-sql object-pad' },
  { 'kfly8/perl-local-lib-path.vim', ft = 'perl', branch = 'perl-project-root-files' },
  { 'rhysd/vim-gfm-syntax', ft = 'markdown' },
  { 'mzlogin/vim-markdown-toc', ft = 'markdown' },
  { 'iamcco/markdown-preview.nvim', ft = 'markdown', build = 'cd app && yarn install' },
  { 'dhruvasagar/vim-table-mode', ft = 'markdown' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  { 'jparise/vim-graphql', ft = 'graphql' },
  { 'syusui-s/scrapbox-vim', ft = 'scrapbox' },
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

-- Coc.vim --
vim.api.nvim_set_keymap('i', '<C-j>', 'coc#pum#visible() ? coc#pum#next(1) : "<C-j>"', {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-k>', 'coc#pum#visible() ? coc#pum#prev(1) : "<C-k>"', {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<Tab>', 'coc#pum#visible() ? coc#pum#confirm() : "<Tab>"', {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<Esc>', 'coc#pum#visible() ? coc#pum#cancel() : "<Esc>"', {noremap = true, expr = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-h>', 'coc#pum#visible() ? coc#pum#cancel() : "<C-h>"', {noremap = true, expr = true, silent = true})

vim.api.nvim_set_keymap('n', '<C-k>', '<Cmd>call v:lua.show_documentation()<CR>', {noremap = true, silent = true})

function show_documentation()
  local filetype = vim.bo.filetype
  if filetype == 'vim' or filetype == 'help' then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  elseif vim.fn['coc#rpc#ready']() then
    vim.fn.CocActionAsync('doHover')
  end
end

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
