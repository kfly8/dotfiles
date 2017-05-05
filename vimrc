"----------------------------------------------------
" Plugin
"----------------------------------------------------
filetype off

call plug#begin('~/.vim/plugged/')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/vimfiler.vim'
Plug 'vim-scripts/Align'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/syntastic'
Plug 'szw/vim-tags'
Plug 'jiangmiao/auto-pairs'
Plug 'thinca/vim-quickrun'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-endwise'
Plug '907th/vim-auto-save'

" Color Scheme
Plug 'tomasr/molokai'

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
Plug 'c9s/perlomni.vim'
Plug 'hotchpotch/perldoc-vim'
Plug 'y-uuki/perl-local-lib-path.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ruby-matchit'
Plug 'marcus/rsense'

" Crystal
Plug 'rhysd/vim-crystal'

" Javascript
Plug 'posva/vim-vue'

call plug#end()

filetype plugin on

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
set nowrap

highlight link ZenkakuSpace Error
match ZenkakuSpace /　/

set ambiwidth=double

"----------------------------------------------------
" Color Scheme
"----------------------------------------------------
set background=dark
colorscheme molokai

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
au BufRead,BufNewFile *.ejs  set filetype=html
au BufRead,BufNewFile *.ctp  set filetype=html
au BufRead,BufNewFile *.tx   set filetype=html
au BufRead,BufNewFile *.erb  set filetype=html
au BufRead,BufNewFile *.psgi set filetype=perl
au BufRead,BufNewFile *.t    set filetype=perl
au BufRead,BufNewFile *.ts   set filetype=javascript


"------------------------------------------------------------------------
" Plugin Config
"------------------------------------------------------------------------

"----------------------------------------------------
" neocomplete
"----------------------------------------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'perl'     : $HOME.'/.vim/dict/perl.dict'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" https://github.com/Shougo/neocomplete.vim/issues/29#issuecomment-20654987
let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'

"----------------------------------------------------
" Snippets
"----------------------------------------------------
let g:neocomplete_ctags_arguments_list = {
   \ 'perl' : '-R -h ".pm"',
   \ 'ruby' : '-R -h ".rb"',
   \ 'crystal' : '-R -h ".cr"',
   \ }

let g:neosnippet#snippets_directory = "~/.vim/snippets"


imap <C-k> <plug>(neosnippet_expand_or_jump)
smap <C-k> <plug>(neosnippet_expand_or_jump)

"----------------------------------------------------
" vimfiler
"----------------------------------------------------
let g:unite_source_file_mru_filename_format = ''
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

nnoremap <silent> <leader>f :VimFiler -split -simple -winwidth=25 -no-quit<CR>

"----------------------------------------------------
" vimshell
"----------------------------------------------------

nnoremap <silent> <leader>s :VimShell<CR>

"----------------------------------------------------
" Align
"----------------------------------------------------

let g:Align_xstrlen=3

vmap <leader>a   :<c-u>Align


"----------------------------------------------------
" quickrun
"----------------------------------------------------

let g:quickrun_config = {
\   "_" : {
\     "runner" : "vimproc",
\     "runner/vimproc/updatetime" : 60,
\     "hook/time/enable" : 1,
\     "outputter/buffer/split" : ":botright 8sp",
\     "outputter/buffer/close_on_empty" : 1
\   }
\ }

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
nnoremap <silent> <leader>r :QuickRun<CR>

"----------------------------------------------------
" auto save
"----------------------------------------------------

let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0 " do not save while in insert mode
let g:auto_save_events = ["InsertLeave", "TextChanged"]

set updatetime=1000

