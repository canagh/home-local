#!/usr/bin/zsh
if [[ -e ~/.zplug/zplug ]] ; then

    source ~/.zplug/zplug
    zplug zsh-users/zsh-syntax-highlighting
    zplug zsh-users/zsh-completions
    autoload -U compinit
    compinit

else
    echo please run '$ curl -sL zplug.sh/installer | zsh'
fi
