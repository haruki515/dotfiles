if has('vim_starting')
	"初回起動時のみruntimepathにneobundleのパスを指定する
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

"NeoBundleを初期化
call neobundle#begin(expand('~/.vim/bundle/'))

"Required:
NeoBundleFetch 'Shougo/neobundle.vim'

"自動補完
NeoBundle 'tpope/vim-endwise'

"ruby構文チェック
NeoBundle 'scrooloose/syntastic.git'

"シンタックスチェック
NeoBundle 'scrooloose/syntastic'

"ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'

"Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'

call neobundle#end()

" マウスを有効にする
if has('mouse')
	set mouse=a
endif

"キーバインド
inoremap <C-a>  <Home>
inoremap <C-e>  <End>
inoremap <C-b>  <Left>
inoremap <C-f>  <Right>
inoremap <C-n>  <Down>
inoremap <C-p>  <UP>
inoremap <C-d>  <Del>
inoremap <C-h>  <BS>
inoremap <silent> <C-h> <C-g>u<C-h>
inoremap <C-k> <ESC>d$i

nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

noremap <Space>h ^
noremap <Space>l $
" 不可視文字の表示記号指定
set listchars=tab:>-,eol:↲,extends:❯,precedes:❮
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P

set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

"文字エンコーディング
set encoding=utf-8
if has('win32') || has('win64')
	set termencoding=cp932
else
	set termencoding=utf-8
endif
set fileencoding=utf-8

"全角スペースを表示
function! ZenkakuSpace()
	highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
	silent! match ZenkakuSpace /　/
endfunction

if has('syntax')
	augroup ZenkakuSpace
		autocmd!
		autocmd VimEnter,BufEnter * call ZenkakuSpace()
	augroup END
endif

"自動文字数カウント
augroup WordCount
    autocmd!
    autocmd BufWinEnter,InsertLeave,CursorHold * call WordCount('char')
augroup END

let s:WordCountStr = ''
let s:WordCountDict = {'word': 2, 'char': 3, 'byte': 4}

function! WordCount(...)
    if a:0 == 0
        return s:WordCountStr
    endif
    let cidx = 3
    silent! let cidx = s:WordCountDict[a:1]
    let s:WordCountStr = ''
    let s:saved_status = v:statusmsg
    exec "silent normal! g\<c-g>"
    if v:statusmsg !~ '^--'
        let str = ''
        silent! let str = split(v:statusmsg, ';')[cidx]
        let cur = str2nr(matchstr(str, '\d\+'))
        let end = str2nr(matchstr(str, '\d\+\s*$'))
        if a:1 == 'char'
            " ここで(改行コード数*改行コードサイズ)を'g<C-g>'の文字数から引く
            let cr = &ff == 'dos' ? 2 : 1
            let cur -= cr * (line('.') - 1)
            let end -= cr * line('$')
        endif
        let s:WordCountStr = printf('%d/%d', cur, end)
    endif
    let v:statusmsg = s:saved_status
    return s:WordCountStr
endfunction

syntax on
set number
set title
set backspace=indent,eol,start
set clipboard=unnamed,autoselect

" ファイル処理関連の設定
set noswapfile
set autoread
set nobackup

" 検索/置換
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

" タブ/インデント
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set noeol   "最終行に改行をいれない


filetype plugin on
filetype indent on
