"----------------------------------------------------
" perl settings
"----------------------------------------------------

au FileType perl PerlLocalLibPath
let g:perl_local_lib_path = "./,t/lib,blib/lib,blib/arch"
let g:perl_sub_signatures = 1

au BufRead,BufNewFile *.psgi set filetype=perl
au BufRead,BufNewFile *.t    set filetype=perl
au BufRead,BufNewFile *.tx set filetype=html

