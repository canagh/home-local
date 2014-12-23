.PHONY: default all basic vim emacs utils git gdb haskell ruby zsh mikutter blog competitoin font

export PATH := $(CURDIR)/bin:$(PATH)

default: basic vim git zsh

all: default basic vim git gdb haskell ruby

basic:
	- mkdir ~/local
	- mkdir ~/lib
	- reln $(CURDIR)/Makefile.lib ~/lib/Makefile
	- mkdir ~/bin
	- mkdir ~/etc
	[ $(CURDIR) -ef ~/share ] || reln $(CURDIR) ~/share

vim:
	- mkdir ~/.vim
	reln $(CURDIR)/vim/vimrc    ~/.vimrc
	reln $(CURDIR)/vim/rc       ~/.vim/rc
	reln $(CURDIR)/vim/after    ~/.vim/after
	reln $(CURDIR)/vim/syntax   ~/.vim/syntax
	reln $(CURDIR)/vim/ftdetect ~/.vim/ftdetect

emacs:
	- mkdir ~/.emacs.d
	reln $(CURDIR)/emacs/elisp   ~/.emacs.d/elisp
	reln $(CURDIR)/emacs/init.el ~/.emacs.d/init.el
	reln $(CURDIR)/emacs/inits   ~/.emacs.d/inits

zsh:
	reln $(CURDIR)/zsh/zshrc ~/.zshrc
	- [ -d ~/.ssh -a ! -d ~/lib/antigen ] && git clone https://github.com/zsh-users/antigen.git ~/lib/antigen

git:
	reln $(CURDIR)/git/gitconfig ~/.gitconfig

gdb:
	reln $(CURDIR)/gdbinit ~/.gdbinit

haskell:
	- mkdir ~/.ghc
	reln $(CURDIR)/ghc/ghci.conf ~/.ghc/ghci.conf
	- mkdir ~/.cabal
	reln $(CURDIR)/cabal/config ~/.cabal/config

ruby:
	reln $(CURDIR)/irbrc ~/.irbrc

blog:
	[ -e ~/local/blog ] || git clone git@github.com:solorab/solorab.github.io.git ~/local/blog
	cd ~/local/blog ; bundle install --path vendor/bundle

competitoin:
	[ -e ~/local/competitoin ] || git clone git@github.com:solorab/competitoin ~/local/competitoin

font:
	mkdir -p ~/.config/fontconfig
	reln $(CURDIR)/X11/font.conf ~/.config/fontconfig
