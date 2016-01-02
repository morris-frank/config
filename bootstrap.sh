#!/bin/sh

cd $(dirname "$0")
PWD=$(pwd)

###
#CONFIG FILES
###
#XRESOURCES
ln -svf "$PWD/Xresources"  "$HOME/.Xresources"

#BASHRC
ln -svf "$PWD/bashrc"  "$HOME/.bashrc"

#BASH_PROFILE
ln -svf "$PWD/bash_profile"  "$HOME/.bash_profile"

#INPUTRC
ln -svf "$PWD/inputrc"  "$HOME/.inputrc"

#NANORC
ln -svf "$PWD/nanorc"  "$HOME/.nanorc"

#SPECTRWM
ln -svf "$PWD/spectrwmrc"  "$HOME/.spectrwm.conf"
ln -svf "$PWD/spectrwm_de.conf"  "$HOME/.spectrwm_de.conf"

#XBINDKEYSRC
ln -svf "$PWD/xbindkeysrc"  "$HOME/.xbindkeysrc"

#XINITRC
ln -svf "$PWD/xinitrc"  "$HOME/.xinitrc"

#ZSH
ln -svf "$PWD/zshrc"  "$HOME/.zshrc"

#EMACS
mkdir "$HOME/.emacs.d" 2> /dev/null
ln -svf "$PWD/emacsrc" "$HOME/.emacs.d/init.el"

#NCMPCPP
mkdir "$HOME/.ncmpcpp" 2> /dev/null
ln -svf "$PWD/ncmpcpprc" "$HOME/.ncmpcpp/config"

#XBOOMX
mkdir "$HOME/.xboomx" 2> /dev/null
ln -svf "$PWD/xboomxrc" "$HOME/.xboomx/config"

#TODO.SH
mkdir "$HOME/.todo" 2> /dev/null
ln -svf "$PWD/todorc" "$HOME/.todo/config"

#COMPTON
ln -svf "$PWD/comptonrc" "$HOME/.compton.conf"


###
#SCRIPTS
###
mkdir "$HOME/bin" 2> /dev/null
ln -svf "$PWD/bar" "$HOME/bin/bar"
ln -svf "$PWD/bar.content.sh" "$HOME/bin/bar.content.sh"
