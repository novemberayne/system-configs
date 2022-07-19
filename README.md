# RayneFall's System Configs

### About

RayneFall's personal system configuration files. These configurations are
intended for kubuntu systems.

##### Requirements
* vim >= 8.0
* zsh >= 5.0
* git
* curl


### Installation
1. Run `./install.sh` and follow the prompts
2. Open Vim and run `:PlugInstall`

If you already have .zshrc and/or .vimrc files, you will be prompted for an
overwrite of your files. Be sure to back up any files you already have before
installing!

Zsh configurations are able to be modified from the .zshrc file, and additional
settings can be added with the file .zshrc.local. Zsh plugins, etc. are housed
in the .oh-my-zsh directory. More can be read about oh-my-zsh here
(https://github.com/robbyrussell/oh-my-zsh).

Vim configurations are able to be modified from the .vimrc file, and additional
settings can be added with the file .vimrc.local. Vim plugins, backup files, and
other configurations can be found in the .vim directory.


### Vim Troubleshooting
If Vim airline is displaying incorrect unicode characters, be sure to correctly
configure your terminals fonts. The recommended font for this package is
"Ubuntu Mono derivative Powerline Regular."
