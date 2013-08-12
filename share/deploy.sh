#!/bin/sh

alias 'dot-link'=$(dirname "$0")/../bin/dot-link
dot_mkdir() {
    mkdir -v ~/."$1"
}
cd $(dirname "$0")

dot-link conkyrc
dot-link screenrc
dot-link sh/profile
dot-link zsh/zshrc
dot-link zsh/zlogout

dot_mkdir vim
dot-link -p vim/vimrc
dot-link -p vim/ftplugin

dot_mkdir X11 ; dot-link X11/*

dot_mkdir cabal ; dot-link -p cabal/*
dot_mkdir ghc ; dot-link -p ghc/*
dot_mkdir xmonad ; dot-link -p xmonad/*

dot-link git/gitconfig gitconfig
ln -siT $(realpath icon/icon48.png) ~/.face
ln -siT $(realpath X11/xsession) ~/.xinitrc

[ -d ~/.vim/bundle/neobundle.vim ] || git clone git@github.com:Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
