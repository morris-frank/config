#!/bin/sh

cd $(dirname "$0")
PWD=$(pwd)

source "$PWD/shell.rc"

#CREATE DIRECTORY ENVIROMENT
###
	echo "${GRE}[bootstrap.sh] Make the home directory structure${RES}"
	mkdir -p "$HOME"
	mkdir -p "$HOME/tmp"
	mkdir -p "$HOME/docs"
	mkdir -p "$HOME/var/music"
	mkdir -p "$HOME/var/pictures"
	mkdir -p "$HOME/var/videos"
###

#CONFIG FILES
###
	echo "${GRE}[bootstrap.sh] Link all config files to their correct positions${RES}"
	#Xresources
	ln -sf "$PWD/Xresources"  "$HOME/.Xresources"

	#shells
	ln -sf "$PWD/shell.rc"  "$HOME/.shellrc"

	#bash
	ln -sf "$PWD/bash.rc"  "$HOME/.bashrc"

	#profile
	ln -sf "$PWD/profile"  "$HOME/.profile"

 	#input
	ln -sf "$PWD/input.rc"  "$HOME/.inputrc"

	#nano
	ln -sf "$PWD/nano.rc"  "$HOME/.nanorc"

	#Xbindkeys
	ln -sf "$PWD/xbindkeys.rc"  "$HOME/.xbindkeysrc"

	#Xinit
	ln -sf "$PWD/xinit.rc"  "$HOME/.xinitrc"

	#git
	ln -sf "$PWD/git.rc" "$HOME/.gitconfig"

	#tmux
	ln -sf "$PWD/tmux/tmux.rc" "$HOME/.tmux.conf"

	#user-dirs
	ln -sf "$PWD/user-dirs.rc" "$HOME/.config/user-dirs.dirs"
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
