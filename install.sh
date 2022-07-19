#!/bin/bash

# Set up Vim directories and configuration files
# ==============================================
vim_setup() {
    ## Copy vim directory to user home
    if ! [ -d "$HOME/.vim" ]; then
        mkdir -r $HOME/.vim
    fi

    # if .vimrc exists, prompt for overwrite
    if [ -e "$HOME/.vimrc" ]; then
        echo -n "Overwrite $HOME/.vimrc? [y/n]: "
        read write_vimrc

        if [ $write_vimrc == "y" ]; then
            cp .vimrc $HOME
        fi
    else
        cp .vimrc $HOME
    fi

    ## Set up vim backup directory
    if ! [ -d "$HOME/.vim/backup" ]; then
        mkdir $HOME/.vim/backup
    fi

    ## Set up vim undo directory
    if ! [ -d "$HOME/.vim/undo" ]; then
        mkdir $HOME/.vim/undo
    fi

    install_plugins
    install_fonts
}

# Install / update powerline fonts
# ================================
install_fonts() {
    ## Install/update powerline fonts for airline
    plugin="https://github.com/powerline/fonts.git"
    if ! [ -d "fonts" ]; then
        printf "Installing powerline fonts..."
        git clone -q $plugin "fonts"
        cd fonts
        printf "[DONE]\n"
    else
        printf "Updating powerline fonts..."
        cd fonts
        git pull -q $plugin
        printf "[DONE]\n"
    fi
    ./install.sh &>/dev/null && cd $WORKING_DIR
}

# Install / update Vim plugins
# ============================
install_plugins() {
    ## Install/update vim plug
    plug="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    printf "Installing Vim Plug..."
    curl -sfLo ~/.vim/autoload/plug.vim --create-dirs $plug > /dev/null
    printf "[DONE]\n"
}


# Install solarized profile and zsh configurations
# ==================================================
term_setup() {
    ## Set up dracula terminal color scheme
    echo -n "Install dracula konsole theme? [y/n]: "
    read install_theme

    if [ $install_theme == "y" ]; then
        cp -r konsole $HOME/.local/share/
        echo
    fi

    ## If .zshrc exists, prompt for overwrite
    if [ -e "$HOME/.zshrc" ]; then
        echo -n "Overwrite $HOME/.zshrc? [y/n]: "
        read write_zshrc

        if [ $write_zshrc == "y" ]; then
            cp .zshrc $HOME
        fi
    else
        cp .zshrc $HOME
    fi

    ## Install oh-my-zsh
    if ! [ -d "$HOME/.oh-my-zsh" ]; then
        echo -n "Install Oh My ZSH? [y/n]: "
        read install_ohmyzsh

        if [ $install_ohmyzsh == "y" ]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

            # Install custom themes and plugins
            cp -r .oh-my-zsh $HOME/.oh-my-zsh
            echo "Installed oh-my-zsh"
        fi
    fi
}

WORKING_DIR=$PWD

echo "Setting up Vim configurations..."
echo "================================"
vim_setup
echo
echo "Setting up term configurations..."
echo "================================"
term_setup
echo
echo "Installation complete!"
