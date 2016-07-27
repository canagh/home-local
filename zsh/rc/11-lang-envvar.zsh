#!/usr/bin/zsh

export CC=clang
export CXX=clang++
export LD=ld.gold
path=( /usr/lib/ccache/bin $path )

if [ -d ~/.cabal/bin ] ; then
    path=( ~/.cabal/bin $path )
fi
if [ -d ~/.gem/ruby/2.1.0/bin ] ; then path=( ~/.gem/ruby/2.1.0/bin $path ) fi
if [ -d ~/.gem/ruby/2.2.0/bin ] ; then path=( ~/.gem/ruby/2.2.0/bin $path ) fi
if [ -d ~/.gem/ruby/2.3.0/bin ] ; then path=( ~/.gem/ruby/2.3.0/bin $path ) fi
if [ -d ~/lib/rbenv/bin ] ; then
    path=( ~/lib/rbenv/bin $path )
    eval "$(rbenv init -)"
fi

export GOPATH=$HOME/.go
path=( $GOPATH/bin $path )

export PYTHONSTARTUP=$HOME/share/python/startup.py

# OPAM configuration
# eval `opam config env`

export path
