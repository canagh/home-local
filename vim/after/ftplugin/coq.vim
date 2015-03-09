if exists('b:did_after_ftplugin')
    finish
endif
let b:did_after_ftplugin = 1

" CoqIDE
nnoremap <buffer> <C-p> :<C-u>CoqIDEUndo<CR>
nnoremap <buffer> <C-n> :<C-u>CoqIDENext<CR>

" coqtop.vim
":CoqStart
