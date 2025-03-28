
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

vim.o.number = true
vim.o.list = true
vim.o.listchars = 'tab:»-,trail:~,eol:↲,extends:»,precedes:«,nbsp:%'
vim.o.showtabline = 2
vim.o.signcolumn = 'yes'
vim.o.whichwrap = 'b,s,h,l,[,],<,>,~'
vim.o.splitright = true
vim.o.mouse = ''
vim.o.backupcopy = "yes"

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
vim.g.goyo_width = 150

-- Colorizer --
require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}

-- lightline --
function LightlineTabFilename(n)
  vim.notify("called LightlineTabFilename")

  local bufnr = vim.fn.tabpagebuflist(n)[vim.fn.tabpagewinnr(n) - 1]
  local filepath = vim.fn.expand("#" .. bufnr .. ":p")

  local parent = vim.fn.fnamemodify(vim.fn.fnamemodify(filepath, ":h"), ":t")
  local name = vim.fn.fnamemodify(filepath, ":t")
  local tab_filename = parent .. "/" .. name

  vim.notify(tab_filename)

  return tab_filename ~= "" and tab_filename or "[No Name]"
end

vim.g.lightline = {
  active = {
    left = { {'mode', 'paste'}, {'readonly', 'relativepath', 'modified'} },
  },
  tab_component_function = {
    filename = "LightlineTabFilename",
    modified = "LightlineTabFilename",
  }
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

