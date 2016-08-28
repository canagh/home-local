#!/usr/bin/zsh

hash -d blog=~/local/blog
hash -d posts=~blog/content/post
hash -d contest=~/local/competitive-programming-workspace
hash -d ctf=~/local/ctf
hash -d golf=~/local/competitive-programming-workspace/anagol

hash -d dt=~/Desktop
hash -d dl=~/Downloads

setopt autocd
function chpwd() { ls }
