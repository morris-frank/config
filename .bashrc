#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export PS1="\h# \e[34;1m\w\e[0m\n\$ "

if [[ ${EUID} == 0 ]] ; then
	PS1='\[\033[01m\][ \[\033[01;31m\]\u ¦ \h \[\033[00m\]\[\033[01m\]] \[\033[1;97m\]\w\[\033[00m\]\n\[\033[01;33m\][\[\033[01;31m\]$?\[\033[01;33m\][\[\033[01;31m\]$\[\033[00m\]> '
else
	PS1='\[\033[01m\][ \[\033[01;34m\]\u ¦ \h \[\033[00m\]\[\033[01m\]] \[\033[1;97m\]\w\[\033[00m\]\n\[\033[01;33m\][\[\033[01;31m\]$?\[\033[01;33m\][\[\033[01;34m\]$\[\033[00m\]> '
fi

#History
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
shopt -s cmdhist
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

#Alias definitions
source ~/etc/.alias
if [ -e ~/etc/.alias_private ]; then
	source ~/etc/.alias_private
fi

#Variable definitons for colors
source ~/etc/.color

#Extra Function defintions
source ~/etc/.function

if [ -e /usr/share/doc/pkgfile/command-not-found.bash ]; then
	source /usr/share/doc/pkgfile/command-not-found.bash
fi

if [ -e ~/etc/.bashrc_private ]; then
	source ~/etc/.bashrc_private
fi
