# Updates editor information when the keymap changes.
zle-keymap-select() {
    zle reset-prompt
    zle -R
}

# Updates time every 30 seconds
# Thanks to Peter Stephenson (https://www.zsh.org/mla/users/2007/msg00946.html)
schedprompt() {
    emulate -L zsh
    zmodload -i zsh/sched

    integer i=${"${(@)zsh_scheduled_events#*:*:}"[(I)schedprompt]}
    (( i )) && sched -$i

    zle && zle reset-prompt

    sched +30 schedprompt
}

precmd() {
    schedprompt
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
    zle &&  zle -R
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

# Enable vi-mode
zle -N zle-keymap-select
zle -N edit-command-line
bindkey -v

# Enable v key to edit
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Enable ctrl-p, ctrl-n for history navigation
bindkey '^P' up-history
bindkey '^N' down-history

# Enable ctrl-h, ctrl-w, ctrl-? for char and word deletion
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# Enable ctrl-r to perform backward search in history
bindkey '^r' history-incremental-search-backward

# Enable ctrl-s to perform backward forward in history
bindkey '^s' history-incremental-search

# Enable ctrl-a, ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
