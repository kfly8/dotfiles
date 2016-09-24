"----------------------------------------------------
" Plugin
"----------------------------------------------------
filetype off

call plug#begin('~/.vim/plugged/')

Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
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

" golang
Plug 'fatih/vim-go'

" Perl
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'c9s/perlomni.vim'
Plug 'y-uuki/perl-local-lib-path.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ruby-matchit'
Plug 'tpope/vim-endwise'
Plug 'marcus/rsense'

" Crystal
Plug 'rhysd/vim-crystal'

" カラースキーム
Plug 'tomasr/molokai'
Plug 'ujihisa/unite-colorscheme'

call plug#end()

"------------------------------------------------------------------------
" 基本的な設定
"------------------------------------------------------------------------

" viとの互換性をとらない(vimの独自拡張機能を使う為)
set nocompatible
" 改行コードの自動認識
set fileformats=unix,dos,mac
" ビープ音を鳴らさない
set vb t_vb=
" バックスペースキーで削除できるものを指定
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start
" 縦幅デフォルトは24
"set lines=50
" 横幅デフォルトは80
"set columns=80
" 自動的に日本語入力(IM)をオン/オフにする機能すべてを禁止
set imdisable
" 文頭で左、文末で右に進むと前後の行にカーソルが移動する。
set whichwrap=b,s,h,l,<,>,[,]
" 改行コード（自動認識）
set fileformats=unix,dos,mac
" 改行コード指定
"set fileformat = unix
"----------------------------------------------------
" バックアップ関係
"----------------------------------------------------
" バックアップをとらない
set nobackup
" ファイルの上書きの前にバックアップを作る
" (ただし、backup がオンでない限り、バックアップは上書きに成功した後削除される)
set writebackup
" バックアップをとる場合
"set backup
" バックアップファイルを作るディレクトリ
"set backupdir=~/backup
" スワップファイルを作るディレクトリ
"set directory=~/swap

"----------------------------------------------------
" 検索関係
"----------------------------------------------------
" コマンド、検索パターンを100個まで履歴に残す
set history=100
" 検索の時に大文字小文字を区別しない
"set ignorecase
" 検索の時に大文字が含まれている場合は区別して検索する
set smartcase
" 最後まで検索したら先頭に戻る
set wrapscan
" インクリメンタルサーチを使わない
set noincsearch

"----------------------------------------------------
" 表示関係
"----------------------------------------------------
" タイトルをウインドウ枠に表示する
set title
" 行番号を表示する
set number
" ルーラーを表示
set ruler
" タブ文字を CTRL-I で表示し、行末に % で表示する
set list
"listで表示される文字のフォーマットを指定する
set listchars=tab:-\ ,extends:<
" 入力中のコマンドをステータスに表示する
set showcmd
" ステータスラインを常に表示
set laststatus=2
" 括弧入力時の対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を2にする
set matchtime=2
" シンタックスハイライトを有効にする
syntax on
" 検索結果文字列のハイライトを有効にする
set hlsearch
" コメント文の色を変更
highlight Comment ctermfg=DarkCyan
" コマンドライン補完を拡張モードにする
set wildmenu

" 入力されているテキストの最大幅
" (行がそれより長くなると、この幅を超えないように空白の後で改行される)を無効にする
set textwidth=0
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
"set wrap
" ウィンドウの幅より長い行は折り返す
set nowrap


" 全角スペースの表示
highlight link ZenkakuSpace Error
match ZenkakuSpace /　/

" 全角記号
set ambiwidth=double

" ステータスラインに表示する情報の指定
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
" ステータスラインの色
highlight StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white

" フォント設定
if has('win32')
  " Windows用
  set guifont=MS_Gothic:h10:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka−等幅:h18
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif

"カラースキーム
" :Unite colorscheme -auto-preview
set background=dark
colorscheme molokai

"----------------------------------------------------
" インデント
"----------------------------------------------------
" オートインデントを無効にする
set noautoindent
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2
" タブを挿入するとき、代わりに空白を使う
set expandtab

"----------------------------------------------------
" 国際化関係
"----------------------------------------------------
" 文字コードの設定
" fileencodingsの設定ではencodingの値を一番最後に記述する
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp
set fileencodings+=,ucs-2le,ucs-2

" ファイルタイプ別インデント、プラグインを有効にする
"filetype plugin indent on
" カーソル位置を記憶する
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
" 入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
" 日本語入力をリセット
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


"----------------------------------------------------
" その他
"----------------------------------------------------

" clipboard
set clipboard+=unnamed

" バッファを切替えてもundoの効力を失わない
set hidden

filetype plugin on

" 起動時のメッセージを表示しない
"set shortmess+=I


let mapleader = "\<Space>"

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


" TABでスニペットを展開
imap <C-k> <plug>(neosnippet_expand_or_jump)
smap <C-k> <plug>(neosnippet_expand_or_jump)


"----------------------------------------------------
" unite.vim
"----------------------------------------------------
" 入力モードで開始する
"let g:unite_enable_start_insert=1
" shortcut
nnoremap <silent> <leader>u :Unite

" タブ一覧
nnoremap <silent> <leader>ut :<C-u>Unite tab<CR>
" バッファ一覧 + 最近使用したファイル一覧
nnoremap <silent> <leader>uu :<C-u>Unite buffer file_mru<CR>


" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"----------------------------------------------------
" vimfiler
"----------------------------------------------------
let g:unite_source_file_mru_filename_format = ''
"デフォルトのエクスプローラーをVimFilerにする
let g:vimfiler_as_default_explorer = 1
"セーフモードを無効にした状態で起動しない
let g:vimfiler_safe_mode_by_default = 0

nnoremap <silent> <leader>f :VimFiler -split -simple -winwidth=25 -no-quit<CR>

"----------------------------------------------------
" vimshell
"----------------------------------------------------

" vimshell を起動
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

"------------------------------------------------------------------------
" Language
"------------------------------------------------------------------------

"----------------------------------------------------
" golang
"----------------------------------------------------

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

function! s:my_set_go_path()
  set path +=$GOPATH/src/**
  let gover  = systemlist('goenv version')[0]
  let gopath = '~/.anyenv/envs/goenv/versions/'. gover. '/src/**'
  exe "set path +=".gopath
endfunction

autocmd FileType go call s:my_set_go_path()

"----------------------------------------------------
" Perl
"----------------------------------------------------

let g:perl_local_lib_path = 't/lib'
autocmd FileType perl PerlLocalLibPath

"----------------------------------------------------
" Ruby
"----------------------------------------------------

let g:rsenseHome = '/usr/local/lib/rsense-0.3'
let g:rsenseUseOmniFunc = 1

