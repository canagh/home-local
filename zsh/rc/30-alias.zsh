#!/bin/sh

alias c=cat
alias cpr='cp -r'
alias e=$EDITOR
alias fg1='fg %1'
alias fg2='fg %2'
alias fg3='fg %3'
alias fg4='fg %4'
alias fg5='fg %5'
alias fg6='fg %6'
alias g=grep
alias j='jobs -l'
alias la='ls -a'
alias lA='ls -A'
alias ll='ls -l'
alias l=ls
alias loc=locate
alias md=mkdir
alias mp='mkdir -p'
alias v=view
function psg() { ps ax | grep "$@" | grep -v grep | awk '{ print $1 }' ; }

# colorize
alias  grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
case $OSTYPE in
    darwin* ) alias ls='ls -G' ;;
    linux*  ) alias ls='ls --color=auto' ;;
esac
