autocmd FileType perl PerlLocalLibPath

let g:perl_sub_signatures = 1

" ALE
let g:ale_perl_syntax_check_config = g:plug_home . '/syntax-check-perl/config/relax.pl'

let g:ale_perl_perltidy_options = ''
let g:ale_perl_perlcritic_showrules = 1

