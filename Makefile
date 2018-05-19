default:
	- ln -s ${CURDIR}/zshrc ~/.zshrc
	- mkdir -p ${HOME}/.config/git
	- ln -s ${CURDIR}/gitconfig ~/.config/git/config
	- ln -s ${CURDIR}/gitignore ~/.config/git/ignore
	- ln -s ${CURDIR}/gdbinit ~/.gdbinit
