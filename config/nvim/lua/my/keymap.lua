vim.g.mapleader = ' '

-- ターミナルモードで、Escキーを押すとノーマルモードに戻す
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

-- fzf 関連のキーマップ
vim.keymap.set("n", "<leader>f", "<cmd>lua require('fzf-lua').git_files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<leader><leader>", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", "<cmd>lua require('fzf-lua').lines()<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", "<cmd>lua require('fzf-lua').tabs()<CR>", { silent = true })

-- lsp 関連のキーマップ
vim.keymap.set('n', '<C-k>',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')

vim.keymap.set('i', '<C-CR>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- Memo
local MEMO_DIR = os.getenv("OBSIDIAN_MEMO_DIR")
local ENGLISH_DIR = os.getenv("OBSIDIAN_ENGLISH_DIR")

vim.keymap.set('n', 'mm', function() Memo('Obsidian Memo> ', MEMO_DIR) end, { noremap = true, silent = true })
vim.keymap.set('n', 'memo', function() Memo('Obsidian Memo> ', MEMO_DIR) end, { noremap = true, silent = true })
vim.keymap.set('n', 'en', function() Memo('Obsidian English> ', ENGLISH_DIR) end, { noremap = true, silent = true })
vim.keymap.set('n', 'english', function() Memo('Obsidian English> ', ENGLISH_DIR) end, { noremap = true, silent = true })

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

-- oil 関連のキーマップ
require("oil").setup({
  default_file_explorer = true,
  keymaps = {
    ["?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-l>"] = "actions.select",
    ["<C-p>"] = "actions.preview",
    ["<C-h>"] = { "actions.parent", mode = "n" },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["t"] = { "actions.select", opts = { tab = true } },
  },
  use_default_keymaps = false,
  view_options = {
    is_hidden_file = function(name)
      local ignore_list = { '.git', '.DS_Store', '.wrangler' }
      for _, v in ipairs(ignore_list) do
        if name == v then
          return true
        end
      end
      return false
    end,
  }
})

