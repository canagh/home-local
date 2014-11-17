#!/usr/bin/zsh

source ~/share/zsh/antigen/antigen.zsh clone/antigen.zsh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle ~/share/zsh/completion
antigen theme ~/share/zsh/theme.zsh
antigen apply
