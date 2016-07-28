#!/usr/bin/zsh

fpath=( $(dirname $(readlink ~/.zshrc))/functions $fpath )
fpath=( $(dirname $(readlink ~/.zshrc))/functions/Prompts $fpath )
