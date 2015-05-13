#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export EDITOR="nano"
export DRI_PRIME=1

#load nvidia settings for x
nvidia-settings -l &

#load background image
sh ~/etc/.fehbg &

#something something cursor
xsetroot -cursor_name left_ptr &

#Deactivate sounds in terminal
xset -b &

#Load X resources
xrdb -load ~/.Xresources &

#personnal bindings
xbindkeys &

function wm() {
	#set WM name
	xsetroot -name $1 &

	#fix for matlab & co
	wmname LG3D &

	#enable RGBA module for GTK
	export GTK_MODULES=rgba &

	#compton -cCb -t-5 -l-5 -r4.2 -o.4
	compton --config ~/etc/.compton.conf &

	#auto hide mouse
	unclutter &

	#audio
	pulseaudio &

	#bar ain't na
	/home/morris/bin/bar.sh &

	#spawn window manager
	exec $1

}

[[ -z $1 ]] && wm spectrwm

wm $1


