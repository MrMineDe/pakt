# Pakt
Pakt (PAcman KaTegories) is a small collection of POSIX-compliant shell scripts for categorizing packages you install on Arch Linux.

- [What are categories?](#what-are-categories)
- [Use cases](#use-cases)
- [`pakt`](#pakt)
- [`pakt-sync`](#pakt-sync)
- [`pakt-dry`](#pakt-dry)
- [Installation](#installation)
- [Uninstallation](#uninstallation)
- [Configuration](#configuration)

## What are categories?
You can order the packages you install in local text files, referred to as categories. They are stored at `$XDG_DATA_HOME/pakt/` (`~/.local/share/pakt/`, if the variable is undefined), like this:

```
> cat ~/.local/share/pakt/dev
emacs
typescript
clang
rustup
```

In all scripts, categories are referred to with `+category`, where "category" is the name of the respective category file.
There is also a shorthand for targetting all categories currently set up on your system, that being `++`.

Just see the examples below.

## Use cases
- Don't keep unused packages on your system by having an overview.
- Set up your system by installing your packages from the category files (kinda like in NixOS).
- Uninstall "temporary" packages in batch (e.g. utilities for programming projects).

## `pakt`
This is the main script, a wrapper around Pacman (or your AUR helper of choice). You can apply the same arguments to it as to Pacman, plus the category syntax.

See also the man page.

### Examples
```
# pakt can act as a replacement of pacman ...
pakt -S neovim

# ... and as a wrapper for your AUR helper
pakt -Rcnsu neovim-git

# Installs neovim and assigns the `editors` category
pakt -S neovim +editors

# Removes firefox and its name from the categories `gui` and `all`
pakt -Rcnsu firefox +gui,all

# Performs a system update, installs htop and lf both in `cli`,
# firefox in `basic` but git only in the default categories (if any configured)
pakt -Syu htop lf +cli firefox +basic git

# Assigns every category from your category directory to emacs.
pakt -S emacs ++
```

## `pakt-sync`
This script is responsible for batch-installing packages from entire categories or any package lists on your system. It can also show what packages are assigned to categories but not installed.

See also the man page.

### Examples
```
# Lists all not installed packages both from the "cli" category and ~/Documents/pacman_Qe_090124.txt
pakt-sync +cli ~/Documents/pacman_Qe_090124.txt

# Installs all packages listed in the "dev" category file
pakt-sync -S +dev

# Removes all packages listed line-by-line in the ~/Downloads/xorg-packages.txt file
pakt-sync -R ~/Downloads/xorg-packages.txt

# Installs all packages from all categories you have
pakt-sync -S ++
```

## `pakt-dry`
This one is similar to `pakt` but there are no Pacman transactions involved. It lets you edit your category files without opening them manually with a text editor.

See also the man page.

### Examples
```
# Prints out the contents of the files "core" and "cli" in the category directory
pakt-dry +core,cli

# Besides the former action, also prints out the contents of ~/Documents/arch_stuff.txt
pakt-dry +core,cli ~/Documents/arch_stuff.txt

# Assigns neovim to the categories "core", "cli" and "dev", regardless whether neovim is actually installed
pakt-dry -S neovim +core,cli,dev

# Removes neovim from category "dev" only but keeps neovim on the system, if it was installed before
pakt-dry -R neovim +dev

# Adds emacs to every category you have, but doesn't install it
pakt-dry -S emacs ++
```

## Installation
```
git clone --depth 1 https://github.com/mrminede/pakt
cd pakt
sudo sh install.sh
```

When you're done, you can remove the source code directory.

## Uninstallation
```
cd pakt
sudo sh uninstall.sh
```

for if you still have the source code directory. Alternatively:

```
curl -LsS https://raw.githubusercontent.com/mrminede/pakt/main/uninstall.sh | sudo sh
```

## Configuration
The configuration is usually done in `/etc/pakt.conf`. By exporting a `PAKT_CONF_PATH` variable in your shell config (e.g. `~/.bashrc`), you can set another path for `pakt.conf`.

In the file, you can choose an AUR helper for `pakt` to wrap around, or just keep Pacman.

You can also assign multiple categories that package names go into by default. Out of the box, it's just "default". But you can also set none.
