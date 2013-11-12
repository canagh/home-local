if exists('b:did_after_ftplugin')
    finish
endif
let b:did_after_ftplugin = 1

setl foldmethod=marker
au BufWritePost <buffer> so <afile>
