# ZSH Compdefs
##############
compdef s=sudo
compdef c=cd
which zathura &>/dev/null && compdef za=zathura
which evince &>/dev/null && compdef ev=evince
compdef g=git
which pacman &>/dev/null && compdef pac=pacman
compdef _git gstat=git-status
compdef _git gd=git-diff
compdef _git gc=git-commit
compdef _git gcmsg=git-commit
compdef _git ga='git-add'
compdef _git gpull=git-pull
compdef _git gpush=git-push
compdef py=python
compdef t=tmux
compdef ta=tmux
compdef sshfs=scp
