default:        basic vim zsh others mikutter
.PHONY: default basic vim zsh others mikutter

basic:
	- mkdir ~/local
	- mkdir ~/lib
	- mkdir ~/bin
	chmod 700 .

zsh:
	- ln -s $(CURDIR)/zsh/zshrc ~/.zshrc
	curl -sL zplug.sh/installer | zsh

vim:
	- git clone https://github.com/kmyk/vimrc ~/local/vimrc
	- make -C ~/local/vimrc

others:
	- ln -s $(CURDIR)/gitconfig ~/.gitconfig
	- ln -s $(CURDIR)/gdbinit ~/.gdbinit
	- mkdir ~/.ghc
	- ln -s $(CURDIR)/ghci.conf ~/.ghc/ghci.conf
	- ln -s $(CURDIR)/irbrc ~/.irbrc

mikutter:
	[ -e ~/lib/mikutter ] || git clone https://github.com/mikutter/mikutter ~/lib/mikutter
	cd ~/lib/mikutter ; bundle install
	mkdir -p ~/.mikutter/plugin
	mkdir -p ~/.local/share/applications
	- ln -s $(CURDIR)/mikutter.desktop ~/.local/share/applications/mikutter.desktop
	mkdir -p ~/.local/share/icons
	- ln -s ~/lib/mikutter/core/skin/data/icon.png ~/.local/share/icons/mikutter.png
	touch ~/.mikutter/plugin/display_requirements.rb
	[ -e ~/.mikutter/plugin/mikutter-sub-parts-client ] || git clone https://github.com/toshia/mikutter-sub-parts-client ~/.mikutter/plugin/mikutter-sub-parts-client
	[ -e ~/.mikutter/plugin/mikutter-subparts-image ] || git clone https://github.com/moguno/mikutter-subparts-image ~/.mikutter/plugin/mikutter-subparts-image
	[ -e ~/.mikutter/plugin/mikutter_sub_parts_voter_multiline ] || git clone https://github.com/rhenium/mikutter_sub_parts_voter_multiline ~/.mikutter/plugin/mikutter_sub_parts_voter_multiline
	[ -e ~/.mikutter/plugin/mikutter-large-pic-twitter-com ] || git clone https://github.com/moguno/mikutter-large-pic-twitter-com ~/.mikutter/plugin/mikutter-large-pic-twitter-com
	cd ~/lib/mikutter ; bundle install
