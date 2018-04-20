"----------------------------------------------------
" Plugin
"----------------------------------------------------

call plug#begin('~/.vim/plugged/')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/denite.nvim',
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'ctrlpvim/ctrlp.vim', { 'do': 'go get github.com/mattn/files' }
Plug 'nixprime/cpsm', { 'do': './install.sh' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'junegunn/vim-easy-align'
Plug 'editorconfig/editorconfig-vim'
Plug 'thinca/vim-quickrun'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'thinca/vim-ref'

" Color Scheme
Plug 'morhetz/gruvbox'

"---------------------
" Plugin Language
"---------------------

" Golang
Plug 'fatih/vim-go', { 'do' : ':GoInstallBinaries' }

" elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Perl
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
"Plug 'kfly8/perlomni.vim'
Plug 'hotchpotch/perldoc-vim'
Plug 'y-uuki/perl-local-lib-path.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ruby-matchit'

" Crystal
Plug 'rhysd/vim-crystal'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'

" TypeScript
Plug 'leafgarland/typescript-vim'

call plug#end()

"------------------------------------------------------------------------
" Common
"------------------------------------------------------------------------

let mapleader = "\<Space>"

set nocompatible
set fileformats=unix,dos,mac
set vb t_vb=
set backspace=indent,eol,start
set imdisable
set whichwrap=b,s,h,l,<,>,[,]
set fileformats=unix,dos,mac
set hidden

"----------------------------------------------------
" Backup
"----------------------------------------------------
set writebackup
set backup
set backupdir=~/backup

"----------------------------------------------------
" Search
"----------------------------------------------------
set history=1000
set smartcase
set wrapscan
set noincsearch

"----------------------------------------------------
" View
"----------------------------------------------------
set title
set number
set ruler
set list
set listchars=tab:-\ ,extends:<
set showcmd
set laststatus=2
set showmatch
set matchtime=2
syntax on
set hlsearch
highlight Comment ctermfg=DarkCyan
set wildmenu
set textwidth=0
set wrap

highlight link ZenkakuSpace Error
match ZenkakuSpace /　/


"----------------------------------------------------
" Indent
"----------------------------------------------------
set noautoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"----------------------------------------------------
" Encoding
"----------------------------------------------------
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8

autocmd BufNewFile,BufRead * set iminsert=0

"----------------------------------------------------
" File type
"----------------------------------------------------
au BufRead,BufNewFile *.erb  set filetype=html
au BufRead,BufNewFile *.psgi set filetype=perl
au BufRead,BufNewFile *.t    set filetype=perl

"----------------------------------------------------
" Color Scheme
"----------------------------------------------------
colorscheme gruvbox

"------------------------------------------------------------------------
" Plugin Config
"------------------------------------------------------------------------

"----------------------------------------------------
" deoplete
"----------------------------------------------------

let g:deoplete#enable_at_startup = 1

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"----------------------------------------------------
" neosnippet
"----------------------------------------------------
let g:neosnippet#snippets_directory = "~/.vim/snippets"

imap <C-k> <plug>(neosnippet_expand_or_jump)
smap <C-k> <plug>(neosnippet_expand_or_jump)

"----------------------------------------------------
" vimfiler
"----------------------------------------------------
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

nnoremap <silent> <leader>f :VimFiler -split -simple -winwidth=40 -no-quit<CR>

"---------------------------------------------------
" ctrlp
"----------------------------------------------------

let g:ctrlp_user_command = 'files -a %s'
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}

"----------------------------------------------------
" Easy Align
"----------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)


"----------------------------------------------------
" quickrun
"----------------------------------------------------

let g:quickrun_config = {
\   "_" : {
\     "runner" : "vimproc",
\     "hook/time/enable" : 1,
\     "outputter/buffer/split" : "vertical :rightbelow 40sp",
\   }
\ }

"let g:quickrun_config["perl"] = {
"\   'cmdopt': '-Ilib',
"\   'exec': 'carton exec perl %o %s',
"\}

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
nnoremap <silent> <leader>r :QuickRun<CR>

"----------------------------------------------------
" ale
"----------------------------------------------------

let g:ale_sign_column_always = 1

let g:ale_linters = {
\   'perl': ['perl', 'perlcritic'],
\}

" Perl
let g:ale_perl_perl_executable = 'perl'
let g:ale_perl_perl_options = '-c -Mwarnings -Ilib'

