syntax on
set modeline

set autoindent
set smartindent

set expandtab
set shiftwidth=4

set relativenumber
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

set history=256

set hlsearch
set incsearch
set ignorecase
set smartcase

set conceallevel=0

" japanese, use UTF-8 {{{
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp
set fileformats=unix,dos,mac
setl fenc=utf-8
setl ff=unix
" }}}

" show space characters {{{
set listchars=trail:_,tab:>\  "
hi ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
"}}}

" swap ; :
nnoremap <silent> ; :
nnoremap <silent> : ;
vnoremap <silent> ; :
vnoremap <silent> : ;

" repeat
nnoremap <silent> ;; :<C-P><CR>

" visual and star
vnoremap * "zy:let @/ = @z<CR>n

" :w with sudo
cabbr w!! w !sudo tee > /dev/null %
