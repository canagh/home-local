if exists('b:did_after_ftplugin')
    finish
endif
let b:did_after_ftplugin = 1

au BufWritePost <buffer> silent make -cb
nnoremap <buffer> <Leader>w :CoffeeCompile watch vert<CR>
