
autoload -U promptinit; promptinit
prompt pure

test -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
test -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
test -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh && source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
test -r /home/morris/.opam/opam-init/init.zsh && . /home/morris/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
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
