#!/usr/bin/zsh

export CC=clang
export CXX=clang++

if [ -d ~/.cabal/bin ] ; then
    path=( ~/.cabal/bin $path )
fi
if [ -d ~/.gem/ruby/2.1.0/bin ] ; then
    path=( ~/.gem/ruby/2.1.0/bin $path )
fi
if [ -d ~/lib/rbenv/bin ] ; then
    path=( ~/lib/rbenv/bin $path )
    eval "$(rbenv init -)"
fi

export PYTHONSTARTUP=$HOME/share/python/startup.py

export path
