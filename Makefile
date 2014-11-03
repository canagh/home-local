.PHONY: default basic vim git gdb haskell ruby

export PATH := $(CURDIR)/bin:$(PATH)

default: basic vim git

basic:
	- mkdir ~/local
	reln $(CURDIR) ~/share

vim:
	- mkdir ~/.vim
	reln $(CURDIR)/vim/vimrc    ~/.vimrc
	reln $(CURDIR)/vim/rc       ~/.vim/rc
	reln $(CURDIR)/vim/after    ~/.vim/after
	reln $(CURDIR)/vim/syntax   ~/.vim/syntax
	reln $(CURDIR)/vim/ftdetect ~/.vim/ftdetect

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
