#!/bin/sh

cd $(dirname "$0")
PWD=$(pwd)

###
#CREATE DIRECTORY ENVIROMENT
###
	mkdir -p "$HOME"
	mkdir -p "$HOME/tmp"
	mkdir -p "$HOME/docs"
	mkdir -p "$HOME/var/music"
	mkdir -p "$HOME/var/pictures"
	mkdir -p "$HOME/var/videos"
###

###
#CONFIG FILES
###
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

	#SpectrWM
	ln -sf "$PWD/spectrwm.rc"  "$HOME/.spectrwm.conf"
	ln -sf "$PWD/spectrwm.bindings.rc"  "$HOME/.spectrwm.bindings.rc"

	#Xbindkeys
	ln -sf "$PWD/xbindkeys.rc"  "$HOME/.xbindkeysrc"

	#Xinit
	ln -sf "$PWD/xinit.rc"  "$HOME/.xinitrc"

	#zsh
	ln -sf "$PWD/zsh.rc"  "$HOME/.zshrc"

	#git
	ln -sf "$PWD/git.rc" "$HOME/.gitconfig"

	#tmux
	ln -sf "$PWD/tmux.rc" "$HOME/.tmux.conf"
###
