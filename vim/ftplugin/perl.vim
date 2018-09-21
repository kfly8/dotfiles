autocmd FileType perl PerlLocalLibPath

let g:perl_sub_signatures = 1

" Perl
let g:ale_perl_perl_executable = 'perl'
let g:ale_perl_perl_options = '-c -Mwarnings -Ilib -Iblib/arch -Iblib/lib -Ilocal/lib/perl5'
let g:ale_perl_perltidy_options = ''
let g:ale_perl_perlcritic_showrules = 1

