#!/bin/sh

alias 'clang++14'='clang++ -std=c++14'
alias 'g++14'='g++ -std=c++14'
alias 'clang++11'='clang++ -std=c++11'
alias 'g++11'='g++ -std=c++11'
alias cc='$CC -std=c99 -Wall'
alias ccg='$CC -std=c99 -Wall -ggdb3 -fsanitize=undefined -DDEBUG'
alias cxx='$CXX -std=c++14 -Wall -O2'
alias cxxg='$CXX -std=c++14 -Wall -ggdb3 -fsanitize=undefined -DDEBUG -D_GLIBCXX_DEBUG'

alias ac=apt-cache
alias ag=apt-get

alias hs=ghci

alias py=py3
alias py2=python2
alias py3=python3

alias clrr='clr -r'
