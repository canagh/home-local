if exists('b:did_after_ftplugin')
    finish
endif
let b:did_after_ftplugin = 1

" http://hashnote.net/2011/12/7/12/

" PEP 8 Indent rule
setl tabstop=8
setl softtabstop=4
setl shiftwidth=4
setl smarttab
setl expandtab
setl autoindent
setl nosmartindent
setl cindent
setl textwidth=80
setl colorcolumn=80

" Folding
setl foldmethod=indent
setl foldlevel=99

let g:jedi#popup_on_dot = 0
