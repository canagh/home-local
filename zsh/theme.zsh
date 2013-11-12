#!/usr/bin/zsh

autoload -U colors
colors
setopt promptsubst

# primary prompt
PROMPT="%{%(?.${fg[blue]}.${fg[red]})%}%(!.#.$)%{$reset_color%} "
PROMPT2="%{%(?.${fg[blue]}.${fg[red]})%}%>%{$reset_color%} "

# right prompt
RPROMPT="%{$fg[green]%}%~%{$reset_color%}"
