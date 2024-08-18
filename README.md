# Pakt
Pakt (PAcman KaTegories) is a Pacman shell wrapper for categorizing packages.

## What are categories?
You can order the packages you install in categories. They are stored in plain text files at `$HOME/.local/share/pakt/`, like this:

```
$HOME/.local/share/pakt/dev
---------------------------
emacs
typescript
clang
rustup
```

## Syntax
| Example                       | Description                                                 |
| ---                           | ---                                                         |
| pakt -S neovim                | Pakt can act as a regular AUR helper                        |
| pakt -S firefox -c gui -c all | installs Firefox and assigns the categories `gui` and `all` |
| pakt -Rns vim -c editors      | Uninstalls vim and removes it from the `editors` category   |
| pakt -f gui                   | Sync all packages listed in `$HOME/.local/share/pakt/gui`   |

## Usecases
- Don't keep unused packages on your system by having an overview.
- Set up your system by installing your packages from the category files (kinda like in NixOS).
- Uninstall temporary packages (e.g. utilities for programming projects).

## Installation
Move `pakt.sh` to a PATH directory, e.g. `$HOME/.local/bin/`.

## TODO
- allow only adding/removing packages from categories without install/uninstall
- support all pacman commands (subcommands with more arguments are not supported, commands after the first argument are interpreted as package)
- allow install/uninstall of all packages in files
- support XDG
- Help command
- make cat shut up if file does not exist
- aur helper support (define pacman command in pacat.sh) (warn from using Aura)
- maybe add option to print out category file
- ~~Add Option to uninstall everything not in categorie files provided and install everything that is in them(only diff, compare with pacman -Qe to not uninstall dependencies)~~ Implemented as -s
- Support autocomplete if possible
- Be POSIX compliant
- Fix -s: Programs that are installed/removed at the same time are not handeld properly at all(if does not work, dont remove package if it is also declared to be installed as argument)(example: pacat -S vim -s; removes vim if it is not in the category file)
- allow configuration(directly in pacat.sh and as arguments) for:
    1. remove packages from all categories during uninstall
    2. default categories
    3. (cmd arg only) exclude default category
    4. (cmd arg only) ignore pacman return value

### TODOs of the co-author
- add `## Configuration` to README
- assign to multiple categories through comma-separation
- remove categories with -C flag
	- `-C kat` removes from `kat`, `-C ` removes from all
- install packages from files with `-f`
- update README after new flags have been implemented
