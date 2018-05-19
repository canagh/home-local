# Set up the prompt
autoload -Uz promptinit
promptinit
prompt off
if [ -z "$SSH_CONNECTION" ] ; then
    PS1=$'%{%(?.\033[34m.\033[31m)%}%(!.#.$)%{\033[0m%} '
else
    PS1=$'[%n@%m] %{%(?.\033[34m.\033[31m)%}%(!.#.$)%{\033[0m%} '
fi

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

setopt histignorealldups sharehistory

# Use modern completion system  (default)
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# Set aliases
export EDITOR=nvim
alias e=$EDITOR
alias r=cat
alias j=jobs
alias md=mkdir
alias ls='\ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias cpr='cp -r'

alias open=xdg-open
alias del='gio trash'
alias clr='gio trash'
function clr() { find -maxdepth 1 -name \*~ -delete }
function clrr() { find -name \*~ -delete }
function chpwd() { ls }

alias cc='clang -std=c99 -Wall'
alias ccg='clang -std=c99 -Wall -ggdb3 -fsanitize=undefined -DDEBUG'
alias cxx='clang++ -std=c++14 -Wall -O2'
alias cxxg='clang++ -std=c++14 -Wall -ggdb3 -fsanitize=undefined -DDEBUG -D_GLIBCXX_DEBUG'
alias py2=python2
alias py3=python3
alias py=py3

export PYTHONSTARTUP=$(dirname $(realpath ~/.zshrc))/python.startup.py

path=( /usr/bin $path )
export path
