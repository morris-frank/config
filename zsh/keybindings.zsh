bindkey -e # Use emacs keybindings

bindkey "^H" backward-word
bindkey "^L" forward-word

bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down

default-backward-delete-word () {
  local WORDCHARS="*?_[]~=&;!#$%^(){}<>"
  zle backward-delete-word
}
zle -N default-backward-delete-word
bindkey '^W' default-backward-delete-word
