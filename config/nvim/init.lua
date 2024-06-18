
require('my.setup')
require('my.keymap')
require('my.lsp')

-- Filetypes
vim.filetype.add({
  extension = {
    psgi = 'perl',
    t = 'perl',
    tx = 'html',
  }
})

-- View
vim.o.number = true
vim.o.list = true
vim.o.listchars = 'tab:»-,trail:~,eol:↲,extends:»,precedes:«,nbsp:%'
vim.o.showtabline = 2
vim.o.signcolumn = 'yes'
vim.o.whichwrap = 'b,s,h,l,[,],<,>,~'

function ZenkakuSpace()
  vim.cmd [[hi ZenkakuSpace cterm=reverse ctermfg=darkgrey gui=reverse guifg=darkgrey]]
end

if vim.fn.has('syntax') then
  vim.api.nvim_create_augroup('ZenkakuSpace', {clear = true})
  vim.api.nvim_create_autocmd('ColorScheme', {group = 'ZenkakuSpace', callback = ZenkakuSpace})
  vim.api.nvim_create_autocmd({'VimEnter', 'WinEnter'}, {group = 'ZenkakuSpace', pattern = '*', command = 'match ZenkakuSpace /　/'})
  ZenkakuSpace()
end

-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.cmd [[colorscheme gruvbox-material]]
vim.cmd [[colorscheme kanagawa]]

----------------------------------------------------------------
-- Plugin Config
----------------------------------------------------------------

-- Goyo --
vim.g.goyo_width = 100

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

