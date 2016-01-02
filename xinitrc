#!/bin/sh
#
# ~/.xinitrc
#

#Initalizes the first time a Window Manager is started
function init_common() {
	export WM_STARTED='1'

	export EDITOR="emacs"
	export DRI_PRIME=1
	# Makes fonts darker and thicker
	export INFINALITY_FT_BRIGHTNESS="-10"
	# Not too sharp, not too smooth
	export INFINALITY_FT_FILTER_PARAMS="16 20 28 20 16"
	#enable RGBA module for GTK
	export GTK_MODULES=rgba

	test -d ~/bin/ && export PATH=~/bin:$PATH
	test -f ~/.Xresources && xrdb -merge ~/.Xresources

	xsetroot -solid \#3e4853
	xsetroot -cursor_name left_ptr

	xset -b
	xset s off

	xbindkeys

	urxvtd -f
	emacs --daemon

	wmname LG3D

	ds unclutter

	type pulseaudio &> /dev/null && ds pulseaudio

	disown
}


#Initalizes the enviroment for a Window Manager
function init_wm() {
	xsetroot -name $1 &

	nvidia-settings --load-config-only

	if test -f ~/.compton.conf; then
		compton --config ~/.compton.conf &
	else
		compton &
	fi

	#If there is a bar wait 5 seconds and start it in own term
	type bar &> /dev/null && ds sh -c 'sleep 5 && bar'

	if type .fehbg; then
		.fehbg
	elif test -f ~/.fehbg; then
		sh ~/.fehbg
	fi

	#spawn window manager
	exec $1
}

[[ -z "$WM_STARTED" ]] && init_common

type $1 &> /dev/null && init_wm $1 || init_wm $(cat /usr/share/xsessions/*.desktop | awk -F'=' '/Exec/ {print $2;exit;}')
