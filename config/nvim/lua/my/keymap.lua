vim.g.mapleader = ' '

-- ターミナルモードで、Escキーを押すとノーマルモードに戻す
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true, silent = true})

-- fzf 関連のキーマップ
vim.api.nvim_set_keymap('n', '<leader><leader>', ':GFiles<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':Lines<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>c', ':Commands<CR>', {noremap = true, silent = true})

-- lsp 関連のキーマップ
vim.keymap.set('n', '<C-k>',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')


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

