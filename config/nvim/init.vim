"----------------------------------------------------
" Plugin
"----------------------------------------------------

call plug#begin('~/.vim/plugged/')
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'editorconfig/editorconfig-vim'
Plug 'Yggdroot/indentLine'
Plug 'cappyzawa/trim.nvim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }

" filer
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'

" comp
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim', { 'do' : ':Copilot setup' }
Plug 'UltiRequiem/coc-zig', {'do': 'yarn install --frozen-lockfile'}
Plug 'nvimdev/lspsaga.nvim'

Plug 'junegunn/goyo.vim'
Plug 'wakatime/vim-wakatime'
Plug 'markonm/traces.vim'

" Plugin Language
Plug 'vim-perl/vim-perl',              { 'for': 'perl', 'do': 'make clean carp highlight-all-pragmas moose test-more try-tiny heredoc-sql object-pad' }
Plug 'kfly8/perl-local-lib-path.vim',  { 'for': 'perl', 'branch': 'perl-project-root-files' }
Plug 'tpope/vim-endwise',              { 'for': 'ruby' }
Plug 'rhysd/vim-gfm-syntax',           { 'for': 'markdown' }
Plug 'mzlogin/vim-markdown-toc',       { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.nvim',   { 'for': 'markdown', 'do': 'cd app && yarn install'  }
Plug 'dhruvasagar/vim-table-mode',     { 'for': 'markdown' }
Plug 'hashivim/vim-terraform',         { 'for': 'terraform' }
Plug 'jparise/vim-graphql',            { 'for': 'graphql' }
Plug 'syusui-s/scrapbox-vim',          { 'for': 'scrapbox' }
Plug 'ziglang/zig.vim',                { 'for': 'zig' }

" Color Scheme and extentions
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
set listchars=tab:»-,trail:~,eol:↲,extends:»,precedes:«,nbsp:%
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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set noautoindent
set smartindent

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
au BufRead,BufNewFile *.mustache set filetype=html
au BufRead,BufNewFile *.tx set filetype=html

"----------------------------------------------------
" Color Scheme
"----------------------------------------------------
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox-material

"----------------------------------------------------
" Terminal
"----------------------------------------------------
tnoremap <Esc> <C-\><C-n>

"------------------------------------------------------------------------
" Plugin Config
"------------------------------------------------------------------------

"----------------------------------------------------
" Filer
"----------------------------------------------------
nmap <silent> <leader>f :Fern . -drawer -width=50 -toggle -keep<CR>

let g:fern#renderer = "nerdfont"
let g:fern_git_status#disable_ignored = 1
let g:fern_git_status#disable_untracked = 1
let g:fern_git_status#disable_submodules = 1
let g:fern_git_status#disable_directories = 1

let g:fern#default_exclude = '.bak$'

"----------------------------------------------------
" fzf
"----------------------------------------------------
nmap <leader><leader> :GFiles<CR>
nmap <leader>b        :Buffers<CR>
nmap <leader>l        :Lines<CR>
nmap <leader>c        :Commands<CR>

"----------------------------------------------------
" Goyo
"----------------------------------------------------
let g:goyo_width = 80

"----------------------------------------------------
" lsp & completion
"----------------------------------------------------

set signcolumn=yes

"----------------------------------------------------
" Coc.vim
"----------------------------------------------------

inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"

" 型情報をみる
nnoremap <silent><C-k> <Cmd>call <SID>show_documentation()<CR>

function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction

"----------------------------------------------------
" lightline
"----------------------------------------------------

" 常にタブを表示する
set showtabline=2

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ },
      \ 'tab_component_function': {
      \   'filename': 'LightlineTabFilename'
      \ }
    \ }

function! LightlineTabFilename(n)
  let bufnr    = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let filepath = expand('#' . bufnr . ':p')

  let parent = fnamemodify(fnamemodify(filepath, ':h'), ':t')
  let name   = fnamemodify(filepath, ':t')
  let tab_filename = parent . '/' . name

  return ('' != tab_filename ? tab_filename : '[No Name]')
endfunction

"----------------------------------------------------
" perl settings
"----------------------------------------------------

autocmd FileType perl PerlLocalLibPath
let g:perl_local_lib_path = "./,t/lib,blib/lib,blib/arch"
let g:perl_sub_signatures = 1
