#!/usr/bin/zsh

autoload -Uz promptinit; promptinit
prompt simple
if [ -n "$SSH_CONNECTION" ] ; then
    PS1=$'[%n@%m] %{%(?.\033[34m.\033[31m)%}%(!.#.$)%{\033[0m%} '
fi
