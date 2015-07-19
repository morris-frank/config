#Various Stuff
###
setopt NOTIFY
setopt AUTO_CD
setopt NO_BEEP
#setopt NO_CLOBBER
bindkey -e

#HISTORY
###
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=50000
setopt APPEND_HISTORY
setopt HIST_IGNORE_SPACE HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt HIST_NO_STORE
setopt EXTENDED_HISTORY
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

#Completition
###
autoload -U compinit
compinit
#View Aliases as normal commands
setopt COMPLETE_ALIASES
#Complete in both directions
setopt COMPLETE_IN_WORD
#ext. Regex in complt.
setopt EXTENDED_GLOB
#Send err. Message when pattern has no result
setopt NOMATCH
#Use Menu compl. after second press
setopt AUTO_MENU
#Use fish like highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#Prompt
###
autoload -U promptinit
promptinit
prompt adam2

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcache"

#zstyle ':completion:*:descriptions' format "- %d -"
#zstyle ':completion:*:corrections' format "- %d - (errors %e})"
#zstyle ':completion:*:default' list-prompt '%S%M matches%s'
#zstyle ':completion:*:manuals' separate-sections true
#zstyle ':completion:*:manuals.(^1*)' insert-sections true
#zstyle ':completion:*' verbose yes


# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes


#Alias definitions
source ~/etc/.alias
if [ -e ~/etc/.alias_private ]; then
	source ~/etc/.alias_private
fi

#Extra Function defintions
#source ~/etc/.function

