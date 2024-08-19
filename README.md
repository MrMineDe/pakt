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
| pakt -S neovim                | Pakt can act as a replacement of pacman|
| pakt -S aur/neovim-git	| but can also be configured as a wrapper for aur helpers like yay|
| pakt -S firefox -C gui -C all | installs Firefox and assigns the categories `gui` and `all` |
| pakt -Rns vim -C editors      | Uninstalls vim and removes it from the `editors` category   |
| pakt -f gui                   | Sync all packages listed in `$HOME/.local/share/pakt/gui`   |

## Usecases
- Don't keep unused packages on your system by having an overview.
- Set up your system by installing your packages from the category files (kinda like in NixOS).
- Uninstall temporary packages (e.g. utilities for programming projects).

## Installation
Move `pakt.sh` to a PATH directory, e.g. `$HOME/.local/bin/`.

## TODO
See the [todo project](https://github.com/users/MrMineDe/projects/1) and the respective issues
