"----------------------------------------------------
" neobundle 
"----------------------------------------------------
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/neobundle/'))

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'motemen/git-vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'vim-scripts/Align'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/httpstatus-vim'
NeoBundle 'teramako/jscomplete-vim'

filetype plugin indent on

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
              \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

"----------------------------------------------------
" 基本的な設定
"----------------------------------------------------
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

"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
"match ZenkakuSpace /　/

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
"colorscheme BlackSea
"colorscheme desert
"colorscheme wombat 
colorscheme molokai
"set background=dark " for solarized
"colorscheme solarized

" molokai setting
let g:molokai_original = 1
let g:rehash256 = 1
"set background=dark

"----------------------------------------------------
" インデント
"----------------------------------------------------
" オートインデントを無効にする
set noautoindent
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" インデントの各段階に使われる空白の数
set shiftwidth=4
" タブを挿入するとき、代わりに空白を使わない
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

"----------------------------------------------------
" オートコマンド
"----------------------------------------------------
if has("autocmd")
	"" ファイルタイプ別インデント、プラグインを有効にする
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
endif



"----------------------------------------------------
" PHP
"----------------------------------------------------
" シンタックスハイライト（PHP）を有効にする
"set syntax=php

" PHP辞書を取得
"autocmd FileType php setlocal dictionary=~/.vim/dict/PHP.dict
"
" PHP Lint
"nmap ,l :call PHPLint()<CR>

""
" PHPLint
"
" @author halt feits <halt.feits at gmail.com>
"
"function PHPLint()
"  let result = system( &ft . ' -l ' . bufname(""))
"  echo result
"endfunction

"----------------------------------------------------
" その他
"----------------------------------------------------
" バッファを切替えてもundoの効力を失わない
set hidden


" 起動時のメッセージを表示しない
"set shortmess+=I

"----------------------------------------------------
" omni 補完
"----------------------------------------------------
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"----------------------------------------------------
" Screen title
"----------------------------------------------------
"let &titlestring = hostname() 
"if &term == "screen"
"    set t_ts=k
"    set t_fs=\
"endif
"if &term == "screen" || &term == "xterm"
"    set title
"endif
"

"----------------------------------------------------
" File type
"----------------------------------------------------
au BufRead,BufNewFile *.ejs  set filetype=html
au BufRead,BufNewFile *.ctp  set filetype=html
au BufRead,BufNewFile *.psgi set filetype=perl
au BufRead,BufNewFile *.t    set filetype=perl

"----------------------------------------------------
" neocomplecache
"----------------------------------------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions',
    \ 'perl'     : $HOME.'/.vim/dict/perl.dict',
    \ 'PHP'      : $HOME.'/.vim/dict/PHP.dict',
    \ }


" Select with <TAB>
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup()
: "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

"----------------------------------------------------
" Javascript
"----------------------------------------------------
let g:jscomplete_use = ['dom', 'moz', 'es6th']
" 折りたたみ
"au FileType javascript call JavaScriptFold()

"----------------------------------------------------
" Snippets
"----------------------------------------------------
let g:neocomplcache_ctags_arguments_list = {
   \ 'perl' : '-R -h ".pm"'
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
noremap <C-P> :Unite

noremap <C-P>ref :Unite ref/


" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" ブックマーク一覧
nnoremap <silent> ,uc :<C-u>Unite bookmark<CR>
" ブックマーク追加
nnoremap <silent> ,ua :<C-u>UniteBookmarkAdd<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,uall :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>


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

nnoremap <silent> ,f :VimFiler -split -simple -winwidth=35 -no-quit<CR>

"----------------------------------------------------
" vimshell
"----------------------------------------------------

" vimshell を起動
nnoremap <silent> ,s :VimShell<CR>


"----------------------------------------------------
" quickrun
"----------------------------------------------------
set splitright "新しいウィンドウを右に開く
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}

"----------------------------------------------------
" Align
"----------------------------------------------------

let g:Align_xstrlen=3

vmap <Space>a   :<c-u>Align
vmap <Space>a;  :<c-u>Align ;
vmap <Space>a=  :<c-u>Align =
" Data::Validator
vmap <Space>av  :<c-u>Align => isa default xor optional },
" 三項演算子
vmap <Space>a3  :<c-u>Align => = ? " : "

