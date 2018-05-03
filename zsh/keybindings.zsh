#Keybindings
bindkey -e
bindkey "$terminfo[khome]" beginning-of-line # Home
bindkey "$terminfo[kend]" end-of-line # End
bindkey "$terminfo[kich1]" overwrite-mode # Insert
bindkey "$terminfo[kdch1]" delete-char # Delete
bindkey "$terminfo[kcuu1]" up-line-or-history # Up
bindkey "$terminfo[kcud1]" down-line-or-history # Down
bindkey "$terminfo[kcub1]" backward-char # Left
bindkey "$terminfo[kcuf1]" forward-char # Right
# bindkey "$terminfo[kpp]" # PageUp
# bindkey "$terminfo[knp]" # PageDown
# Bind ctrl-left / ctrl-right
bindkey "^F" backward-word
bindkey "^B" forward-word
