if exists('b:did_after_ftplugin')
    finish
endif
let b:did_after_ftplugin = 1

setl tabstop=8
setl softtabstop=4
setl shiftwidth=4
setl smarttab
setl expandtab
setl autoindent
setl nosmartindent
setl cindent

" neco-ghc
let b:necoghc_enable_detailed_browse = 1
" vim2hs
let b:haskell_conceal_enumerations = 0
" unite-haddock
let b:unite_source_haddock_browser = 'firefox'
nmap <silent> [unite]d :Unite haddock<CR>

" ghc-mod
nmap <buffer> <Leader>ft :GhcModType<CR>
nmap <buffer> <Leader>fu :HierUpdate<CR>
nmap <buffer> <Leader>fc :HierClear<CR>
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
