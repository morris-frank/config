#!/bin/sh
BAR_FONT='-*-dina-medium-r-*-*-8-*-*-*-*-*-iso8859-*'
#BAR_FONT='xft:Inconsolata:size=8:antialias=false'
BAR_BACKGROUND='#ff0a0a0a'
#BAR_BACKGROUND='#000a0a0a'
TRAY_BACKGROUND='#0a0a0a'

#if pgrep "(bar-aint)|(bar.sh)";then
#	echo $(pgrep "(bar-aint)|(bar.sh)")
	#pkill "(bar-aint)|(bar.sh)"
	#wait $(pgrep "(bar-aint)|(bar.sh)")
#fi
~/bin/bar.content.sh |  lemonbar -d -p -f "$BAR_FONT"  -B "$BAR_BACKGROUND" &

wait
