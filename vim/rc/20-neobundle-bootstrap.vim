if has('unix') && isdirectory(expand('~/.ssh'))
    if has('vim_starting')
        if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
            echo "install neobundle..."
            call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
        endif
    endif
endif
