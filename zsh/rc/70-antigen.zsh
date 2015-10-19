#!/usr/bin/zsh

if [[ -d ~/lib/antigen ]] ; then
    source ~/lib/antigen/antigen.zsh

    antigen-bundle zsh-users/zsh-syntax-highlighting

    antigen-bundle zsh-users/zsh-completions
    fpath=( ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions.git/src $fpath ) # fpath support is in pull request
    compinit

    antigen-bundle rupa/z
    source ~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-rupa-SLASH-z.git/z.sh

    antigen-bundle kmyk/OnlineJudgeHelper

    compinit -U
fi
