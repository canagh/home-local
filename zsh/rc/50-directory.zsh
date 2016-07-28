#!/usr/bin/zsh

hash -d blog=~/local/blog
hash -d posts=~blog/content/post
hash -d contest=~/local/competitive-programming-workspace

hash -d dt=~/Desktop
hash -d dl=~/Downloads

setopt autocd
function chpwd() { ls }
