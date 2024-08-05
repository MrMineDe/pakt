# pacat
Pacman Shell Wrapper, to order and manage your packages in easy text files
## What are Categories?
Categories are just simple text files.
In .local/share/pacat/ are all categories stored as file.
Every line is one package. They can be modified by hand easily without any complications.
## Description and Syntax 
This is an easy shell script, that lets you sort your packages in categories, aka plain text files
- Example: `pacat -S firefox -c gui -c all` installs firefox and adds it to the categories gui and all
- Example: `pacat -S neovim` just installs firefox
- Example: `pacat -Rs vim -c editors -c all` uninstalls vim and removes it from the categories editors and all
## Usecases
- Useful for resetting your system. You can easily get set up on the new system.
- Store all installed packages in categories.
Then, if you want to install/uninstall packages you can edit the categoriyfile (or edit it through the command line)
and refresh your system. A bit like nix but with the benefits of pacman.
- Just have an overview over all the packages you are installing over the years and remember to remove them from time to time
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
- maybe add option to print out category file
- allow configuration(directly in pacat.sh and as arguments) for:
    1. remove packages from all categories during uninstall
    2. default categories
    3. (cmd arg only)exclude default category
    4. (cmd arg only)ignore pacman return value
