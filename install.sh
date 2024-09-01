#!/bin/sh

echo "Starting pakt intallation ..."

echo "Putting executable at /usr/bin/pakt ..."
install -m 755 pakt /usr/bin/pakt

echo "Installing the man pages ..."
gzip pakt.1
install -m 644 pakt.1.gz /usr/share/man/man1/pakt.1.gz
gzip pakt-sync.1
install -m 644 pakt-sync.1.gz /usr/share/man/man1/pakt-sync.1.gz

echo "Putting default config at /etc/pacman.conf.default ..."
install -m 644 pakt.conf.default /etc/pakt.conf.default
cp /etc/pakt.conf.default /etc/pakt.conf

echo "Installation complete :)"
