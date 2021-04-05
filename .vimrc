"----------------------------------------------------------
"  dein Scripts
"----------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.vim/dein')
  call dein#begin('$HOME/.vim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.vim/dein/repos/github.com/Shougo/dein.vim')

  " プラグインを設定
  " NerdTree
  call dein#add('preservim/nerdtree')
  " 閉じ括弧補完
  call dein#add('cohama/lexima.vim')
  " HTMLなど 閉じタグ自動補完
  call dein#add('alvan/vim-closetag')
  " HTML 対応するタグをハイライト
  call dein#add('valloric/matchtagalways')
  " コード補完
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " Git関連
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tomasr/molokai')
  
" Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" インストールされていないものは自動インストールする
if dein#check_install()
  call dein#install()
endif

"----------------------------------------------------------
"  nerdtree
"----------------------------------------------------------
let g:NERDTreeShowBookmarks=1

" vim起動時に自動的に開く
" autocmd vimenter * NERDTree

" ファイルが指定されていない場合NerdTreeを開く
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" トグル
nnoremap <C-n> :NERDTreeToggle<CR>
inoremap <C-n> <ESC>:NERDTreeToggle<CR>

" 別タブでも既存のNerdTreeを共有
let NERDTreeShowHidden=1 


" ディレクトリ表示記号を変更する
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'


"----------------------------------------------------------
"  vim-closetag
"----------------------------------------------------------
let g:closetag_filenames = '*.html,*.xhtml,*.php'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,php'
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'


"----------------------------------------------------------
"  matchtagalways
"----------------------------------------------------------
"オプション機能ONにする
let g:mta_use_matchparen_group = 1

"使用するファイルタイプ(phpを追加)
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'php' : 1,
    \}


"----------------------------------------------------------
"  neosnippet-snippets
"----------------------------------------------------------
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" <C-k>で、TARGETのところへジャンプ
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" 独自スニペットファイルのあるディレクトリを指定
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory=$HOME.'/.vim/dein/vim-neosnippets/'

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


"----------------------------------------------------------
"  neocomplete.vim
"----------------------------------------------------------
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" 辞書ファイルを設定
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : ''
    \ }

"辞書ファイル設定する場合は上記にこちら追加
"    \ 'php' : $HOME.'/.vim/dein/dict/php.dict'

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
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'


"----------------------------------------------------------
"  vim-gitgutter
"----------------------------------------------------------
" 記号更新のタイミングを早くする
set updatetime=250
" ハイライトを有効にする
"let g:gitgutter_highlight_lines = 1

"----------------------------------------------------------
"  プラグイン以外の基本設定
"----------------------------------------------------------
" カラースキーム
colorscheme molokai

" vim内部で使用される文字コード
set encoding=utf-8
" バッファのファイルの文字コード（fileencodingが空の場合はencodingと同じ値となるため外す
"set fileencoding=utf-8
" 編集開始時に考慮する文字コード(自動判別の設定)
set fileencodings=utf-8 
"ファイルフォーマット
set fileformats=unix,dos,mac

" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


" 見た目系
" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
"set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk


" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
"set list listchars=tab:\▸\-
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set list
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
"set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
"set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻るをオフにする
set nowrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>


" vim-closetag とは別のHTMLの閉じタグ補完
" </ を入力すると、対応するタグを補完してくれる
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype php inoremap <buffer> </ </<C-x><C-o>
augroup END

" 括弧入力後改行した際、括弧の補完とカーソルを入力位置に移動
" neocompleteでまかなえているのでコメントアウト
"inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap [<Enter> []<Left><CR><ESC><S-o>
"inoremap (<Enter> ()<Left><CR><ESC><S-o>

" スクロールを滑らかにする
map <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
map <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>

" ファイルを開く際リスト表示・選択できるようにする
set wildmenu wildmode=list:full

" syntaxが消えてしまったりする際使用
"redrawtime=10000

" マウスを使う場合
"set mouse=a
"set ttymouse=xterm2

" ctags
" 開いているファイルのディレクトリから、ホームディレクトリまでtagsを探す
autocmd FileType php set tags=./tags;$HOME
" tagsジャンプの時に複数ある場合は一覧表示                                        
nnoremap <C-]> g<C-]> 
inoremap <C-]> <ESC>g<C-]> 

" 最後にヤンクしたものをペースト
nnoremap P "0p<CR>

" Leader
let mapleader = "\<Space>"

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" ESC代替え
noremap! jj <ESC> 

" PHP Laravel blade用
autocmd BufNewFile,BufRead *.blade.php set filetype=html

" バックスペースが効かないため
set backspace=indent,eol,start

" 列をハイライト
set cursorcolumn
nnoremap <Leader>c :<C-u>setlocal cursorline! cursorcolumn!<CR>

" 対応するタグへジャンプ HTML
source $VIMRUNTIME/macros/matchit.vim
