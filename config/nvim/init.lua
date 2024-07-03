
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
vim.o.splitright = true

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

-- Colorizer --
require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}

-- lightline --
vim.g.lightline = {
  active = {
    left = { {'mode', 'paste'}, {'readonly', 'relativepath', 'modified'} },
  },
}

-- Fzf --
function Memo(prompt, dir)
  require('fzf-lua').fzf_exec("ls", {
    prompt=prompt,
    cwd=dir,
    previewer="builtin",
    actions = {
      ["default"] = function (selected)
        if selected[1] == nil then
          vim.cmd("lcd " .. dir .. " | enew")
        else
          local file_path = dir .. "/" .. selected[1]
          vim.cmd("edit " .. file_path)
        end
      end,
    },
  })
end

-- filter

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
