# Pakt
Pakt (PAcman KaTegories) is a POSIX-compliant Pacman shell wrapper for categorizing packages.

## What are categories?
You can order the packages you install in categories. They are stored in plain text files at `$XDG_DATA_HOME/pakt/`, like this:

```
$HOME/.local/share/pakt/dev
---------------------------
emacs
typescript
clang
rustup
```

## Examples
```
# pakt can act as a replacement of pacman ...
pakt -S neovim

# ... and as a wrapper for your AUR helper
pakt -S neovim-git

# Installs neovim and assigns the `editors` category
pakt -S neovim +editors

# Installs firefox and assigns the categories `gui` and `all`
pakt -S firefox +gui +all

# Performs system update, installs htop and lf both in `cli`,
# firefox in `basic` but git only in the default categories (if any configured)
pakt -Syu htop lf +cli firefox +basic git
```

## Use cases
- Don't keep unused packages on your system by having an overview.
- Set up your system by installing your packages from the category files (kinda like in NixOS).
- Uninstall temporary packages (e.g. utilities for programming projects).

## Installation
```
git clone https://github.com/mrminede/pakt
cd pakt
sudo sh install.sh
```

When you're done, you can remove the source code directory.

## Uninstallation
```
curl -LsS https://raw.githubusercontent.com/mrminede/pakt/main/uninstall.sh | sudo sh
```

Or if you still have the source code directory:

```
cd path/to/pakt
sudo sh uninstall.sh
```

## TODO
See the [todo project](https://github.com/users/MrMineDe/projects/1) and the respective issues
