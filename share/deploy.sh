#!/bin/sh

make_dot_link() {
    from="$1"
    case $# in
        1 ) to="$1" ;;
        2 ) to="$2" ;;
        * ) echo $(basename "$0")': make_dot_link: wrong number of arguments' >&2 ; exit 1 ;;
    esac
    ln -siT $(realpath "$from") ~/."$to"
}

# make the link at home with dot
dot_file() {
    dir=$(dirname "$1")
    [ "$dir" = '.' ] || [ -d ~/."$dir" ] || mkdir -p ~/."$dir" >/dev/null 2>&1
    make_dot_link "$1"
}

# make links of contained files at home with dot
dot_files_dir() {
    for file in $(ls "$1"); do
        make_dot_link "$1"/"$file" "$file"
    done
}

# make the dot-dir and links of contained files
dot_dir_nolink() {
    mkdir ~/."$1" >/dev/null 2>&1
    for file in $(ls -1 "$1"); do
        make_dot_link "$1"/"$file"
    done
}

if [ $(realpath "$0") = ~/local/share/deploy.sh ]; then
    cd $(dirname "$0")

    dot_file conkyrc
    dot_file screenrc
    dot_file zsh/zshrc
    dot_file vim/vimrc
    dot_file vim/ftplugin
    dot_file sh/profile

    dot_files_dir X11

    dot_dir_nolink cabal
    dot_dir_nolink ghc
    dot_dir_nolink xmonad

    make_dot_link git/gitconfig gitconfig
    make_dot_link icon/icon48.png face
    make_dot_link X11/xsession xinitrc

    [ -d ~/.vim/bundle/neobundle.vim ] || git clone git@github.com:Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
fi
