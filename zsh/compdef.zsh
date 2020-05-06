# ZSH Compdefs
##############
compdef s=sudo
compdef c=cd
compdef g=git
compdef _git gstat=git-status
compdef _git gd=git-diff
compdef _git gc=git-commit
compdef _git gcmsg=git-commit
compdef _git ga='git-add'
compdef _git gpull=git-pull
compdef _git gpush=git-push
which zathura &>/dev/null && compdef za=zathura
which evince &>/dev/null && compdef ev=evince
which pacman &>/dev/null && compdef pac=pacman
which python &>/dev/null && compdef py=python
which tmux &>/dev/null && compdef t=tmux
which tmux &>/dev/null && compdef ta=tmux
which scp &>/dev/null && compdef sshfs=scp
which rsync &>/dev/null && compdef rcp=rsync
compdef '_files -g "*"' play
