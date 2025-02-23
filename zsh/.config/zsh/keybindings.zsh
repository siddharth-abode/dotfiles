bindkey -v
export KEYTIMEOUT=1
VIM_MODE_VICMD_KEY='jj'

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char
bindkey -a '^[[3~' vi-delete-char

# Add "jj" shortcut to enter NORMAL mode
bindkey -M viins 'jj' vi-cmd-mode
