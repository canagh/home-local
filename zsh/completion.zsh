#!/usr/bin/zsh

# user completions
ZSH_USER_FPATH=($HOME/share/zsh/completion $HOME/lib/2ch-tools/completion)
fpath=($ZSH_USER_FPATH $fpath)
function() {
    local f
    for f in $ZSH_USER_FPATH; do
        autoload -U $f/*(:t)
    done
}

# init
autoload -U compinit ; compinit -u


# utility functions
function 'reload/c'() {
    local f
    for f in $ZSH_USER_FPATH; do
        f=("$f"/*(.))
        unfunction $f:t 2> /dev/null
        autoload -U $f:t
    done
}
function 'del/cc'() {
    del ~/.zcompcache/*
    del ~/.zcompdump
    compinit
}

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes

# 以下よく分からない

zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# color possible completions
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' menu select=1 # select completion by arrow-keys

# sudo cmd で補完したいけど補完が効かない…、という場合
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
