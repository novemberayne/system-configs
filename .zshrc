### ZSH Settings
###############################

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="raynefall"
CASE_SENSITIVE=true

# Load Plugins
plugins=(
    aws,
    git,
    helm,
    kubectl,
    docker,
    docker-compose,
    raynefall-mode
)

source $ZSH/oh-my-zsh.sh

### PATH CONFIG
###############################

# Java
#export JAVA_HOME=...

# PostgreSQL
#export PG_HOME=...

# Path setup
#export PATH=$JAVA_HOME/bin:$PG_HOME/bin:$HOME/bin:$PATH

### SYSTEM SETTINGS
###############################

# System Vars
export LANG=en_US.UTF-8
export SSH_KEY_PATH=$HOME/.ssh/dsa_id

# Editor Preferrence
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR="vim"
else
   export EDITOR="vim"
fi

### ALIASES
###############################
alias reload="source ~/.zshrc"

### LOCAL CONFIG
###############################

# Source external configs
source $HOME/.aws

# source local zshrc
if [ -e $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi
