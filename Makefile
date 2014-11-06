.PHONY: default all basic vim git gdb haskell ruby

export PATH := $(CURDIR)/bin:$(PATH)

default: basic vim git

all: default basic vim git gdb haskell ruby

basic:
	- mkdir ~/local
	- mkdir ~/lib
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

utils:
	apt-get install trash-cli tree realpath

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

direnv:
	[ -e ~/lib/direnv ] || git clone git@github.com:zimbatm/direnv.git ~/lib/direnv
	make -C ~/lib/direnv
	reln ~/lib/direnv/direnv ~/bin/direnv

blog:
	[ -e ~/local/blog ] || git clone git@github.com:solorab/solorab.github.io.git ~/local/blog
	cd ~/local/blog ; bundle install --path vendor/bundle

mikutter:
	[ -e ~/lib/mikutter ] || git clone git@github.com:mikutter/mikutter.git ~/lib/mikutter
	cd ~/lib/mikutter ; bundle install --path vendor/bundle
	reln ~/share/mikutter.desktop ~/.local/share/applications/
	reln ~/lib/mikutter/core/skin/data/icon.png ~/.local/share/icons/mikutter.png
