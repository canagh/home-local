.PHONY: default all basic vim git gdb haskell ruby zsh

export PATH := $(CURDIR)/bin:$(PATH)

default: basic vim git zsh

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

competitoin:
	[ -e ~/local/competitoin ] || git clone git@github.com:solorab/competitoin ~/local/competitoin

mikutter:
	[ -e ~/lib/mikutter ] || git clone git@github.com:mikutter/mikutter.git ~/lib/mikutter
	mkdir -p ~/.mikutter/plugin
	cd ~/lib/mikutter ; bundle install --path vendor/bundle
	reln ~/share/mikutter.desktop ~/.local/share/applications/
	reln ~/lib/mikutter/core/skin/data/icon.png ~/.local/share/icons/mikutter.png

mikutter/plugin:
	touch ~/.mikutter/plugin/display_requirements.rb
	[ -e ~/.mikutter/plugin/mikutter-sqlite-datasource ] || git clone https://github.com/toshia/mikutter-sqlite-datasource ~/.mikutter/plugin/mikutter-sqlite-datasource
	[ -e ~/.mikutter/plugin/mikutter-sub-parts-client ] || git clone https://github.com/toshia/mikutter-sub-parts-client ~/.mikutter/plugin/mikutter-sub-parts-client
	[ -e ~/.mikutter/plugin/mikutter-subparts-image ] || git clone https://github.com/moguno/mikutter-subparts-image ~/.mikutter/plugin/mikutter-subparts-image
	reln ~/.mikutter/plugin/mikutter-subparts-image/sub_parts_image ~/.mikutter/plugin/sub_parts_image
	reln ~/.mikutter/plugin/mikutter-subparts-image/openimg ~/.mikutter/plugin/openimg
	[ -e ~/.mikutter/plugin/mikutter_sub_parts_voter_multiline ] || git clone https://github.com/rhenium/mikutter_sub_parts_voter_multiline ~/.mikutter/plugin/mikutter_sub_parts_voter_multiline
	[ -e ~/.mikutter/plugin/mikutter_focus_to_tab_just_meet ] || git clone https://github.com/moguno/mikutter_focus_to_tab_just_meet ~/.mikutter/plugin/mikutter_focus_to_tab_just_meet
	[ -e ~/.mikutter/plugin/mikutter-auto-close-proftab ] || git clone https://github.com/moguno/mikutter-auto-close-proftab ~/.mikutter/plugin/mikutter-auto-close-proftab
	[ -e ~/.mikutter/plugin/mikutter-large-pic-twitter-com ] || git clone https://github.com/moguno/mikutter-large-pic-twitter-com ~/.mikutter/plugin/mikutter-large-pic-twitter-com
	[ -e ~/.mikutter/plugin/mikutter_update_with_media ] || git clone https://github.com/penguin2716/mikutter_update_with_media ~/.mikutter/plugin/mikutter_update_with_media
	cd ~/lib/mikutter ; bundle install --path vendor/bundle

zsh:
	reln $(CURDIR)/zsh/zshrc ~/.zshrc
	[ -d ~/.ssh ] && git clone https://github.com/zsh-users/antigen.git ~/lib/antigen
