if has('unix') && isdirectory(expand('~/.ssh'))
    if has('vim_starting')
        set nocompatible               " Be iMproved

        " Required:
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    " Required:
    call neobundle#begin(expand('~/.vim/bundle/'))

    " Let NeoBundle manage NeoBundle
    " Required:
    NeoBundleFetch 'Shougo/neobundle.vim'
endif
