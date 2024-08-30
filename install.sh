#!/bin/sh

echo "Starting pakt intallation ..."

echo "Putting executable at /usr/bin/pakt ..."
install -m 755 pakt /usr/bin/pakt

echo "Installing the man pages ..."
install -m 644 pakt.1 /usr/share/man/man1/pakt.1
install -m 644 pakt-sync.1 /usr/share/man/man1/pakt-sync.1

echo "Creating config directory at ~/.config/pakt ..."
mkdir -p $HOME/.config/pakt/categories

echo "Putting default config at /etc/pacman.conf.example ..."
install -m 644 pakt.conf.example /etc/pakt.conf.example

echo "Creating config file at ~/.config/pakt/pakt.conf ..."
cp pakt.conf.example $HOME/.config/pakt/pakt.conf

echo "Installation complete :)"
