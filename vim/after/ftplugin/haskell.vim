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
let g:necoghc_enable_detailed_browse = 1
" unite-haddock
let g:unite_source_haddock_browser = 'firefox'
" vim2hs
let g:haskell_conceal_enumerations = 0
