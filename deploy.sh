#!/bin/sh

with_log() { echo "$@" ; "$@" ; }
link() {
    if echo $1 | grep -q '~$' ; then return ; fi
    if [ -e $2 ] ; then
        if [ `realpath $1` != `realpath $2` ] ; then
            echo `basename $0`: error: link $1 $2: file $2 exists \(and it isnt $1\) 1>&2
        fi
    else
        with_log ln -sT `realpath $1` $2
    fi
}
dot_link() { link $1 ~/.$2 ; }
dot_link_path() { for f in $@ ; do link $f ~/.$f            ; done ; }
dot_link_base() { for f in $@ ; do link $f ~/.`basename $f` ; done ; }
dot_mkdir()     { for f in $@ ; do [ -d ~/.$f ] || with_log mkdir ~/.$f ; done ; }

cd $(dirname "$0")

dot_link_base zsh/zshrc
dot_link_base zsh/zlogin
dot_link_base zsh/zlogout

dot_link_base profile
dot_link_base gnomerc

dot_mkdir vim
dot_link_base vim/vimrc
dot_link_path vim/ftplugin
dot_mkdir vim/after
dot_link_path vim/after/ftplugin

dot_link_base X11/*
dot_link X11/xsession xinitrc

dot_mkdir cabal  ; dot_link_path cabal/*
dot_mkdir ghc    ; dot_link_path ghc/*
dot_mkdir xmonad ; dot_link_path xmonad/*

dot_link_base irbrc

dot_link_base git/gitconfig
dot_link icon/icon.svg face

dot_mkdir 2ch-tools
dot_link 2ch 2ch-tools/user

dot_mkdir local
dot_mkdir local/share
dot_mkdir local/share/applications
dot_link_path local/share/applications/*
dot_mkdir local/share/nautilus
dot_mkdir local/share/nautilus/scripts
dot_link_path local/share/nautilus/scripts/*

dot_link_base keysnail.js
[ -d ~/.vim/bundle/neobundle.vim ] || with_log git clone git@github.com:Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
