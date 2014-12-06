#!/usr/bin/zsh
if hash direnv >/dev/null ; then
    eval "$(direnv hook zsh)"
fi
