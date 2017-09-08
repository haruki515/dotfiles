" Vundle

set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'basyura/TweetVim'
Bundle 'mattn/webapi-vim'
Bundle 'basyura/twibill.vim'
Bundle 'tyru/open-browser.vim'
Bundle 'h1mesuke/unite-outline'
Bundle 'basyura/bitly.vim'
Bundle 'Shougo/unite.vim'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"-----------
" tweetvim
"-----------
let mapleader = "\<Space>"
nnoremap <silent><Leader>tw :<C-u>tabnew <Bar> TweetVimHomeTimeline<CR>
nnoremap <silent><Leader>tl :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent><Leader>tm :<C-u>TweetVimMentions<CR>
nnoremap <silent><Leader>ty :<C-u>tabnew <Bar>TweetVimSearch suhgde<CR>
nnoremap <Leader>ts :<C-u>TweetVimSay<CR>
let g:tweetvim_display_icon = 1
let g:tweetvim_tweet_per_page = 60

augroup TweetVimSetting
  autocmd!
  " マッピング
  "     " 挿入・通常モードでsayバッファを閉じる
  autocmd FileType tweetvim_say nnoremap <buffer><silent><C-g>         :<C-u>q!<CR>
  autocmd FileType tweetvim_say inoremap <buffer><silent><C-g><C-o>    :<C-u>q!<CR><Esc>
  " 各種アクション
  autocmd FileType tweetvim     nnoremap <buffer>s                :<C-u>TweetVimSay<CR>
  autocmd FileType tweetvim     nnoremap <buffer>m                :<C-u>TweetVimMentions<CR>
  autocmd FileType tweetvim     nmap     <buffer>c                <Plug>(tweetvim_action_in_reply_to)
  autocmd FileType tweetvim     nnoremap <buffer>t                :<C-u>Unite tweetvim -no-start-insert -quick-match<CR>
  autocmd FileType tweetvim     nmap     <buffer><Leader>F        <Plug>(tweetvim_action_remove_favorite)
  autocmd FileType tweetvim nmap <buffer><Leader>d <Plug>(tweetvim_action_remove_status)
  " リロード
  autocmd FileType tweetvim nmap <buffer><Tab> <Plug>(tweetvim_action_reload)
  " ページの先頭に戻ったらリロード
  autocmd FileType tweetvim nmap <buffer><silent>gg gg<Plug>(tweetvim_action_reload)
  " ページ移動をff/bb からf/bに
  autocmd FileType tweetvim     nmap     <buffer>f                <Plug>(tweetvim_action_page_next)
  autocmd FileType tweetvim nmap <buffer>b <Plug>(tweetvim_action_page_previous)
  " favstarやweb UIで表示
  autocmd FileType tweetvim nnoremap <buffer><Leader><Leader> :<C-u>call <SID>tweetvim_favstar()<CR>
  " ブラウザで対象ユーザーのホームを開く
  autocmd FileType tweetvim nnoremap <buffer><Leader>u :<C-u>call <SID>tweetvim_open_home()<CR>
  " 不要なマップを除去
  autocmd FileType tweetvim     nunmap   <buffer>ff
  autocmd FileType tweetvim nunmap <buffer>bb
augroup END

syntax enable
set number
set ruler
set incsearch
set hlsearch
set nowrap
set showmatch
set whichwrap=h,l
set nowrapscan
set ignorecase
set smartcase
set hidden
set history=2000
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set helplang=en
set backspace=indent,eol,start
nnoremap ;  :
nnoremap :  ;
vnoremap ;  :
vnoremap :  ;
noremap!  
"" 消去、編集
imap <C-k> <ESC>d$i
imap <C-y> <ESC>pi
imap <C-d> <ESC>xi
"" 移動
noremap <Space>h ^
noremap <Space>l $

imap <C-a>  <Home>
imap <C-e>  <End>
imap <C-b>  <Left>
imap <C-f>  <Right>
imap <C-n>  <Down>
imap <C-p>  <UP>

" 空白文字の表示
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%

set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
