# Nox theme for use with oh-my-zsh, derived from agnoster's theme
#   (https://gist.github.com/3712874) by agnoster
#
# Format: [I] (venv) [H:M] user@host:path branch [staged]
#         $
#
# Author: raynefall
#
# Notes: Requires unicode for git characters

# display custom virtualenv indicator
prompt_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo -n "%{$fg[magenta]%}(venv) "
    else
        echo -n ""
    fi
}

# display time in hours:minutes
prompt_time() {
    echo -n "%{$fg[white]%}$(date +'[%H:%M]') "
}

# display vi mode
prompt_vi() {
    NORMAL="%{$fg[yellow]%}[N]"
    INSERT="%{$fg[green]%}[I]"
    MODE="${${KEYMAP/vicmd/$NORMAL}/(main|viins)/$INSERT} "

    if [[ "$MODE" == " " ]]; then
        echo -n "$INSERT "
    else
        echo -n "$MODE"
    fi
}

# display user and host information
prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        echo -n "%{$fg[blue]%}$USER@%m"
    fi
}

# if error code returned, display red prompt, else green
prompt_status() {
    if [[ $RETVAL -ne 0 ]]; then
        echo -n "%{$fg[red]%}"
    else
        echo -n "%{$fg[green]%}"
    fi
}

# display current path
prompt_path() {
    echo -n "%{$fg[magenta]%}:%~"
}

# display git branch (green, clean; yellow, dirty) and staging info
prompt_git() {
    local ref dirty mode repo_path
    repo_path=$(git rev-parse --git-dir 2>/dev/null)

    # if in git directory, display info
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null)

        # if branch is dirty, display yellow info, else green
        if [[ -n $dirty ]]; then
            echo -n " %{$fg[yellow]%}\ue0a0"
        else
            echo -n " %{$fg[green]%}\ue0a0"
        fi

        # set branch mode depending on git status
        if [[ -e "${repo_path}/BISECT_LOG" ]]; then
            mode="<B>"
        elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
            mode=">M<"
        elif [[ -e "${repo_path}/rebase" || \
                -e "${repo_path}/rebase-apply" || \
                -e "${repo_path}/rebase-merge" || \
                -e "${repo_path}/../.dotest" ]]; then
            mode=">R>"
        fi

        # enable vcs_info
        setopt promptsubst
        autoload -Uz vcs_info

        # set vcs_info style
        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' stagedstr '+'
        zstyle ':vcs_info:*' unstagedstr '-'
        zstyle ':vcs_info:*' formats '%u%c'
        zstyle ':vcs_info:*' actionformats '%u%c'
        vcs_info
        echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR}" \
                "${vcs_info_msg_0_%%}${mode}"
    fi
}

# construct prompt
build_prompt() {
  RETVAL=$?
  prompt_vi
  prompt_venv
  prompt_time
  prompt_context
  prompt_path
  prompt_git
  prompt_status
}

PROMPT='
$(build_prompt)
$ %{$reset_color%}'
