#!/usr/bin/zsh
if hash direnv >/dev/null 2>&1 ; then
    eval "$(direnv hook zsh)"
fi
