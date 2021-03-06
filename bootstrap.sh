#!/bin/sh

cd $(dirname "$0")
PWD=$(pwd)

source "$PWD/profile.rc"

#CREATE DIRECTORY ENVIROMENT
###
	echo "${GREEN}[bootstrap.sh] Make the home directory structure${RES}"
	mkdir -p "$HOME"
	mkdir -p "$HOME/tmp"
	mkdir -p "$HOME/docs"
	mkdir -p "$HOME/var/music"
	mkdir -p "$HOME/var/pictures"
	mkdir -p "$HOME/var/videos"
###

#CONFIG FILES
###
	echo "${GREEN}[bootstrap.sh] Link all config files to their correct positions${RES}"
	#Xresources
	ln -sf "$PWD/Xresources"  "$HOME/.Xresources"

	#bash
	ln -sf "$PWD/bash.rc"  "$HOME/.bashrc"

	#profile
	ln -sf "$PWD/profile.rc"  "$HOME/.profile"

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
	ln -sf "$PWD/tmux.rc" "$HOME/.tmux.conf"
###

# Setting up ZSH
###
  if type zsh &> /dev/null; then
		echo "${GREEN}[bootstrap.sh] Setting up ZSH${RES}"
		ln -sf "$PWD/zsh.rc"  "$HOME/.zshrc"
  fi
###
