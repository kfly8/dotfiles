----------------------------------------------------
-- perl settings
----------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "perl",
  command = "PerlLocalLibPath"
})

vim.g.perl_local_lib_path = "./,t/lib,blib/lib,blib/arch"
vim.g.perl_sub_signatures = 1
