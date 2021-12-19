"----------------------------------------------------
" Plugin
"----------------------------------------------------

call plug#begin('~/.vim/plugged/')
Plug 'Shougo/vimproc.vim',   { 'do': 'make' }
Plug 'Shougo/denite.nvim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'editorconfig/editorconfig-vim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" filer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'

" ale, coc
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/goyo.vim'
Plug 'wakatime/vim-wakatime'
Plug 'markonm/traces.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/tagbar'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'

" Plugin Language
Plug 'fatih/vim-go',                   { 'for': 'go',   'do': ':GoUpdateBinaries' }
Plug 'vim-perl/vim-perl',              { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny class' }
Plug 'yuuki/perl-local-lib-path.vim',  { 'for': 'perl' }
Plug 'skaji/syntax-check-perl',        { 'for': 'perl' }
Plug 'pangloss/vim-javascript',        { 'for': ['javascript', 'typescript', 'vue', 'javascript.jsx'] }
Plug 'jelera/vim-javascript-syntax',   { 'for': ['javascript', 'typescript', 'vue', 'javascript.jsx'] }
Plug 'posva/vim-vue',                  { 'for': ['javascript', 'typescript', 'vue', 'javascript.jsx'] }
Plug 'leafgarland/typescript-vim',     { 'for': 'typescript' }
Plug 'tpope/vim-endwise',              { 'for': 'ruby' }
Plug 'tpope/vim-rails',                { 'for': 'ruby' }
Plug 'rhysd/vim-gfm-syntax',           { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc',       { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim',   { 'for': 'markdown', 'do': 'cd app && yarn install'  }
Plug 'dhruvasagar/vim-table-mode',     { 'for': 'markdown' }
Plug 'rust-lang/rust.vim',             { 'for': 'rust' }

" Color Scheme and extentions
Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

set undofile
set undodir=/tmp/vim/undodir

set completeopt=menuone

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
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
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

function! ZenkakuSpace()
  hi ZenkakuSpace cterm=reverse ctermfg=darkgrey gui=reverse guifg=darkgrey
endfunction

if has('syntax')
  augroup ZenkakuSpace
  autocmd!
  autocmd ColorScheme       * call ZenkakuSpace()
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

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

language en_US.UTF-8

"----------------------------------------------------
" File type
"----------------------------------------------------
au BufRead,BufNewFile *.psgi set filetype=perl
au BufRead,BufNewFile *.t    set filetype=perl

"----------------------------------------------------
" Color Scheme
"----------------------------------------------------
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox-material

"------------------------------------------------------------------------
" Plugin Config
"------------------------------------------------------------------------

"----------------------------------------------------
" completion
"----------------------------------------------------
imap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"----------------------------------------------------
" snippet
"----------------------------------------------------

let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetsDir = '~/.vim/snippets'
set runtimepath+=~/.vim/snippets

"----------------------------------------------------
" Filer
"----------------------------------------------------
nmap <silent> <leader>f :Fern . -drawer -width=35 -toggle -keep<CR>

let g:fern#renderer = "nerdfont"
let g:fern_git_status#disable_ignored = 1
let g:fern_git_status#disable_untracked = 1
let g:fern_git_status#disable_submodules = 1
let g:fern_git_status#disable_directories = 1

"----------------------------------------------------
" Easy Align
"----------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <Leader>a <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <Leader>a <Plug>(EasyAlign)

"----------------------------------------------------
" ale
"----------------------------------------------------

let g:ale_sign_column_always = 1

let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'perl': ['syntax-check', 'perlcritic'],
\   'rust': ['cargo', 'rls'],
\   'javascript': ['eslint'],
\   'markdown': ['textlint'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'rust': ['rustfmt'],
\}

let g:ale_rust_rls_toolchain = 'stable'
let g:ale_completion_enabled = 1

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

let g:ale_sign_error = ''
let g:ale_sign_warning = ''

" エラーと警告がなくなっても開いたままにする
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 5

let g:ale_fix_on_save = 1

hi Search guibg=peru guifg=wheat

"----------------------------------------------------
" markdown
"----------------------------------------------------

let g:markdown_fenced_languages = ['perl', 'typescript', 'javascript', 'ruby']
let g:gfm_syntax_emoji_conceal = 1

"----------------------------------------------------
" fzf
"----------------------------------------------------
nmap <leader><leader> :GFiles<CR>
nmap <leader>b        :Buffers<CR>
nmap <leader>l        :Lines<CR>

"----------------------------------------------------
" Goyo
"----------------------------------------------------
let g:goyo_width = 80


"----------------------------------------------------
" coc.nvim
"----------------------------------------------------
let g:coc_global_extensions = [
\    'coc-tsserver', 
\    'coc-eslint8',
\    'coc-prettier',
\    'coc-git',
\    'coc-fzf-preview',
\    'coc-lists',
\    'coc-solargraph',
\    'coc-perl'
\]

