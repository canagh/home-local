#!/usr/bin/zsh

hash -d blog=~/local/blog
hash -d posts=~blog/source/_posts
hash -d contest=~/local/competition/contest
hash -d codevs=~contest/etc/codevs/2014

hash -d s=~/share
hash -d d=~/Desktop
hash -d dl=~/Downloads

setopt autocd
function chpwd() { ls }
