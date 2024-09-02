#!/bin/sh

echo "Starting pakt intallation ..."

echo "Putting executables at /usr/bin/pakt, /usr/bin/pakt-dry and /usr/bin/pakt-sync ..."
install -m 755 pakt /usr/bin/pakt
install -m 755 pakt-sync /usr/bin/pakt-dry
install -m 755 pakt-sync /usr/bin/pakt-sync

echo "Installing the man pages ..."
install -m 644 pakt.1 /usr/share/man/man1/pakt.1
gzip /usr/share/man/man1/pakt.1
install -m 644 pakt-dry.1 /usr/share/man/man1/pakt-dry.1
gzip /usr/share/man/man1/pakt-dry.1
install -m 644 pakt-sync.1 /usr/share/man/man1/pakt-sync.1
gzip /usr/share/man/man1/pakt-sync.1

echo "Putting default config at /etc/pacman.conf.default ..."
install -m 644 pakt.conf.default /etc/pakt.conf.default
cp /etc/pakt.conf.default /etc/pakt.conf

echo "Installation complete :)"
