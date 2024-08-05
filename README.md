# pacat
## Introduction
Pacman Shell Wrapper, to order and manager your packages in easy text files
## Description and Use
This is an easy shell script, that lets you sort your packages in categories, aka plain text files
Example: `pacat -S firefox -c gui -c all` installs firefox and adds it to the categories gui and all
Example: `pacat -S neovim` just installs firefox
Example: `pacat -Rs vim -c editors -c all` uninstalls vim and removes it from the categories editors and all
## Installation
clone the repository and move pacat.sh to some path in PATH. E.g. ~/.local/bin/
## TODO
- allow only adding/removing packages without install/uninstall
- support all pacman commands (subcommands with more arguments are not supported, commands after the first argument are interpreted as package)
- allow install/uninstall of all packages in files
- support XDG
- Help command
- make cat shut up if file does not exist
- aur helper support (define pacman command in pacat.sh)
- allow configuration(directly in pacat.sh and as arguments) for:
    1. remove packages from all categories during uninstall
    2. default categories
    3. (cmd arg only)exclude default category
    4. (cmd arg only)ignore pacman return value
