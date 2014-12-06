if has('unix') && isdirectory(expand('~/.ssh'))

    set t_Co=256
    set background=light
    let g:hybrid_use_Xresources = 1
    colorscheme hybrid

    call autochmodx#register_scriptish_detector('autochmodx#detect_scriptish_by_main')
    let g:autochmodx_scriptish_file_patterns = ['\c.*\*.sh', '\c.*\*.pl']
    let g:autochmodx_no_CursorHold_autocmd = 1

endif
