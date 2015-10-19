if exists('b:did_after_ftplugin')
    finish
endif
let b:did_after_ftplugin = 1

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'
execute 'helptags ' . g:opamshare . '/merlin/vim/doc'
execute ':source '  . g:opamshare . '/vim/syntax/ocp-indent.vim'
