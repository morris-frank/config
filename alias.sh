# Make Aliases applicable
#########################
	alias sudo='sudo '
	alias man='man '

# Short Commands
################
	alias ...='cd ../..'
	alias ..='cd ..'
	alias c='cd '
	alias cs='cd ~/src/morris-frank/'
	alias clc=' reset'
	alias f='find . |grep '
	alias h='history|grep '
	alias ipy='ipython '
	alias j='joe '
	alias jl='julia '
	alias jpy='jupyter notebook &>/dev/null&! '
	alias n='nano '
	alias p='ps aux |grep '
	alias pac='pacman '
	alias py='python '
	alias q='exit'
	alias rcp='rsync -a --progress --stats '
	alias s='sudo '
	alias t='tmux '
	alias ta='tmux attach '
	alias v='source .venv/bin/activate'
	alias x='atool -x '
	alias za='zathura '

# Default options
#################
	alias cp='cp --reflink=auto '
	alias echo='echo -e '
	alias egrep='egrep --color=auto '
	alias fgrep='fgrep --color=auto '
	alias g++='g++ -fdiagnostics-color=always '
	alias gcc='gcc -fdiagnostics-color=always '
	alias grep='grep --color=auto '
	alias less='less -R '
	alias mkdir='mkdir -p -v'
	alias ssh='TERM=xterm ssh '
	alias watch='watch --no-title --differences '
	alias jpegoptim='jpegoptim -s -m90 -f '
	alias yay='yay --sortby=popularity '
	if type lsd &> /dev/null; then
		alias l='lsd'
		alias ls='lsd -l'
		alias لس='lsd -l'
	else
		alias l='ls --color=force -phlgo'
		alias ls='ls --color=force -phl'
		alias لس='ls --color=force -phl'
	fi

# Script-Like aliases
#####################
	alias view_webcam='mpv /dev/video0 --vf=mirror --vf=eq=1.2:1.5:0.0:1.1:1.2:1.0:1.1'
	alias هوا='curl wttr.in/Amsterdam?lang=en'
	alias play='mpv --lavfi-complex="[aid1]asplit [ao], afifo, showspectrum=color=fire:scale=sqrt:orientation=vertical:overlap=1:fscale=lin:start=150:stop=2000, format=rgb0 [vo]"'
	#alias play_chillwave='play --no-video --demuxer-seekable-cache=no https://www.youtube.com/watch?v=5qap5aO4i9A'

# GIT
#####
	alias g='git'
	alias gs='git status'
	alias gd='git diff'
	alias gc='git commit -m'
	alias ga='git add'
	alias gpull='git pull origin $(current_branch)'
	alias gpush='git push origin $(current_branch)'

# Optirun / Nvidia
##################
	alias v_status='optimus-manager --status'
	alias v_nvidia='optimus-manager --switch nvidia'
	alias v_intel='optimus-manager --switch intel'
	alias v_switch='sudo prime-switch'
	alias v_offload='prime-offload'
