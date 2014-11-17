#!/usr/bin/zsh

if [ -f ~/share/zsh/auto-fu.zsh/auto-fu.zsh ] ; then
    source ~/share/zsh/auto-fu.zsh/auto-fu.zsh
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
fi
