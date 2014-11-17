#!/usr/bin/zsh

setopt histignorealldups
setopt sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/local/zsh.history
