source /usr/share/zsh/scripts/zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
   printf "Install? [y/N]: "
   if read -q; then
       echo; zplug install
   fi
fi

# Then, source plugins and add commands to $PATH
zplug load

#Git plugin
###
	autoload -Uz vcs_info
	zstyle ":vcs_info:*" enable git
	zstyle ":vcs_info:(git*):*" get-revision true
	zstyle ":vcs_info:(git*):*" check-for-changes true

	local _branch="%c%u%m %{$fg[green]%}%b%{$reset_color%}"
	local _repo="%{$fg[green]%}%r %{$fg[yellow]%}%{$reset_color%}"
	local _revision="%{$fg[yellow]%}%.7i%{$reset_color%}"
	local _action="%{$fg[red]%}%a%{$reset_color%}"
	zstyle ":vcs_info:*" stagedstr "%{$fg[yellow]%}✓%{$reset_color%}"
	zstyle ":vcs_info:*" unstagedstr "%{$fg[red]%}✗%{$reset_color%}"
	zstyle ":vcs_info:git*" formats "$_branch:$_revision - $_repo"
	zstyle ":vcs_info:git*" actionformats "$_branch:$_revision:$_action - $_repo"
	zstyle ':vcs_info:git*+set-message:*' hooks git-stash
###
