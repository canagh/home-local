#!/usr/bin/zsh

setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt incappendhistory
setopt sharehistory
setopt noflowcontrol

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/local/zsh.history
