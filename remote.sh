#!/bin/sh

cd $(dirname "$0")
PWD=$(pwd)

source "$PWD/shell.rc"

#CONFIG FILES
###
	echo "${GRE}[bootstrap.sh] Link all config files to their correct positions${RES}"
	#bash
	ln -sf "$PWD/bash.rc"  "$HOME/.bashrc"

	#profile
	ln -sf "$PWD/profile.rc"  "$HOME/.profile"

 	#input
	ln -sf "$PWD/input.rc"  "$HOME/.inputrc"

	#nano
	ln -sf "$PWD/nano.rc"  "$HOME/.nanorc"

	#git
	ln -sf "$PWD/git.rc" "$HOME/.gitconfig"

	#tmux
	ln -sf "$PWD/tmux.rc" "$HOME/.tmux.conf"
###

# Setting up ZSH
###
  if type zsh &> /dev/null; then
		echo "${GRE}[bootstrap.sh] Setting up ZSH${RES}"
		ln -sf "$PWD/zsh.rc"  "$HOME/.zshrc"
		rm -rf $HOME/.zplug
		curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
  fi
###
