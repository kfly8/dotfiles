"----------------------------------------------------
" Plugin
"----------------------------------------------------

call plug#begin('~/.vim/plugged/')

Plug 'Shougo/vimproc.vim',      { 'do': 'make' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'thinca/vim-quickrun',     { 'on': 'QuickRun' }
Plug 'Shougo/unite.vim',
Plug 'Shougo/vimfiler.vim',
Plug 'Shougo/unite-outline',
Plug 'kannokanno/previm',
Plug 'nathanaelkane/vim-indent-guides'

" Plugin Language
Plug 'fatih/vim-go',                   { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'elixir-lang/vim-elixir',         { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim',        { 'for': 'elixir' }
Plug 'vim-perl/vim-perl',              { 'for': 'perl', 'do': 'make clean carp moose highlight-all-pragmas test-more try-tiny lodash' }
Plug 'y-uuki/perl-local-lib-path.vim', { 'for': 'perl' }
Plug 'vim-ruby/vim-ruby',              { 'for': 'ruby' }
Plug 'vim-scripts/ruby-matchit',       { 'for': 'ruby' }
Plug 'rhysd/vim-crystal',              { 'for': 'crystal' }
Plug 'pangloss/vim-javascript',        { 'for': ['javascript', 'typescript', 'vue'] }
Plug 'posva/vim-vue',                  { 'for': ['javascript', 'typescript', 'vue'] }
Plug 'leafgarland/typescript-vim',     { 'for': 'typescript' }
Plug 'godlygeek/tabular',              { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown',        { 'for': 'markdown' }
Plug 'jparise/vim-graphql'

" Color Scheme
set background=dark
Plug 'morhetz/gruvbox'

call plug#end()

"------------------------------------------------------------------------
" Common
"------------------------------------------------------------------------

let g:mapleader = "\<Space>"

set fileformats=unix,dos,mac
set visualbell t_vb=
set backspace=indent,eol,start
set imdisable
set whichwrap=b,s,h,l,<,>,[,]
set fileformats=unix,dos,mac
set hidden
set swapfile
set virtualedit=block

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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"----------------------------------------------------
" Encoding
"----------------------------------------------------
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

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

imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"----------------------------------------------------
" neosnippet
"----------------------------------------------------
let g:neosnippet#snippets_directory = '~/.vim/snippets'

imap <C-k> <plug>(neosnippet_expand_or_jump)
smap <C-k> <plug>(neosnippet_expand_or_jump)

"----------------------------------------------------
" Filer
"----------------------------------------------------
let g:vimfiler_as_default_explorer = 1

call vimfiler#custom#profile('default', 'context', {
\   'safe' : 0,
\ })
nnoremap <silent> <leader>f :VimFiler -split -simple -winwidth=25 -no-quit<CR>

"----------------------------------------------------
" unite-outline
"----------------------------------------------------
nnoremap <silent> <leader>o <ESC>:Unite -vertical -winwidth=60 -no-quit outline<Return>

"----------------------------------------------------
" previm
"----------------------------------------------------
let g:previm_open_cmd = 'open -a Safari'

nmap <leader>p :PrevimOpen<Return>

"----------------------------------------------------
" indent-guildes 
"----------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1

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
\   '_' : {
\     'runner' : 'vimproc',
\     'hook/time/enable' : 1,
\     'outputter/buffer/split' : 'vertical :rightbelow 40sp',
\   }
\ }

"let g:quickrun_config['perl'] = {
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
\   'perl': ['perl', 'perlcritic']
\}

let g:ale_fixers = {
\   'perl': ['perltidy']
\}


let g:ale_fix_on_save = 0


