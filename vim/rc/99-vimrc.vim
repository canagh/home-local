let mapleader=" "
let maplocalleader=" "

syntax on
set modeline

set autoindent
set smartindent

set expandtab
set shiftwidth=4

set relativenumber "相対行表示
au vimrc CursorMoved,CursorMovedI,WinLeave * setl nocursorline
au vimrc CursorHold,CursorHoldI            * setl cursorline
au vimrc CursorMoved,CursorMovedI,WinLeave * setl nocursorcolumn
au vimrc CursorHold,CursorHoldI            * setl cursorcolumn
hi CursorColumn term=underline cterm=underline ctermbg=none
set report=0
set ruler
set list

set backup " {{{
if has('persistent_undo')
    set undodir=~/.vim/undo
    if !isdirectory(&undodir)
        call mkdir(&undodir)
    endif
    set undofile
endif " }}}

set history=128

set hlsearch " highlightする
set incsearch " incremental検索
" 大文字を混ぜて検索した場合だけ大文字/小文字を区別する
set ignorecase
set smartcase

" 日本語に対応 UTF-8を使う {{{
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp
set fileformats=unix,dos,mac
setl fenc=utf-8
setl ff=unix
" }}}

" 空白文字の表示 {{{
set listchars=trail:_,tab:>\ 
hi ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
"}}}

" swap ; :
nnoremap <silent> ; :
nnoremap <silent> : ;
nnoremap <silent> ;; :<C-P><CR>

" visual and star
vnoremap * "zy:let @/ = @z<CR>n

" colorscheme {{{
set t_Co=256
set background=light
let g:hybrid_use_Xresources = 1
colorscheme hybrid
" }}}
