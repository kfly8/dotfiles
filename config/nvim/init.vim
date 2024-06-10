"----------------------------------------------------
" Plugin
"----------------------------------------------------

call plug#begin('~/.config/nvim/plugged/')
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'Yggdroot/indentLine'
Plug 'cappyzawa/trim.nvim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }

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

set number
set list
set listchars=tab:»-,trail:~,eol:↲,extends:»,precedes:«,nbsp:%
set showtabline=2
set signcolumn=yes

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

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox-material

tnoremap <Esc> <C-\><C-n>

"------------------------------------------------------------------------
" Plugin Config
"------------------------------------------------------------------------

" fzf ---
nmap <leader><leader> :GFiles<CR>
nmap <leader>b        :Buffers<CR>
nmap <leader>l        :Lines<CR>
nmap <leader>c        :Commands<CR>

" Goyo ---
let g:goyo_width = 80

" Coc.vim ---
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"
inoremap <silent><expr> <Esc> coc#pum#visible() ? coc#pum#cancel() : "\<Esc>"
inoremap <silent><expr> <C-h> coc#pum#visible() ? coc#pum#cancel() : "\<C-h>"

nnoremap <silent><C-k> <Cmd>call <SID>show_documentation()<CR>

function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction

" lightline ---
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ },
      \ 'tab_component_function': {
      \   'filename': 'LightlineTabFilename'
      \ }
    \ }

" Vimのタブ名が、index.tsxだけで見づらかったので、直親ディレクトリ名も表示する
" Ref: https://zenn.dev/kfly8/scraps/2b97b46ca25fbe
function! LightlineTabFilename(n)
  let bufnr    = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
  let filepath = expand('#' . bufnr . ':p')

  let parent = fnamemodify(fnamemodify(filepath, ':h'), ':t')
  let name   = fnamemodify(filepath, ':t')
  let tab_filename = parent . '/' . name

  return ('' != tab_filename ? tab_filename : '[No Name]')
endfunction

