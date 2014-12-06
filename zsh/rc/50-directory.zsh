#!/usr/bin/zsh

hash -d blog=~/local/blog
hash -d posts=~blog/source/_posts
hash -d contest=~/local/competition/contest

hash -d d=~/Desktop
hash -d dt=~/Desktop
hash -d dl=~/Downloads
hash -d doc=~/Documents
hash -d pic=~/Pictures
hash -d pub=~/Public
hash -d vid=~/Videos

setopt autocd
function chpwd() { ls }
