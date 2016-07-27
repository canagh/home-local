#!/usr/bin/zsh

hash -d blog=~/local/blog
hash -d posts=~blog/content/post
hash -d contest=~/local/competition/contest

hash -d s=~/share
hash -d d=~/Desktop
hash -d c=~/local/competition
hash -d dl=~/Downloads

setopt autocd
function chpwd() { ls }
