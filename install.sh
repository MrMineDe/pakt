#!/bin/sh

echo -e "Starting pakt intallation ...\n"

# Scripts
install -vm 755 pakt /usr/bin/pakt
install -vm 755 pakt-dry /usr/bin/pakt-dry
install -vm 755 pakt-sync /usr/bin/pakt-sync

# Manpages
install -vm 644 pakt.1 /usr/share/man/man1/pakt.1
gzip -v /usr/share/man/man1/pakt.1
install -vm 644 pakt-dry.1 /usr/share/man/man1/pakt-dry.1
gzip -v /usr/share/man/man1/pakt-dry.1
install -vm 644 pakt-sync.1 /usr/share/man/man1/pakt-sync.1
gzip -v /usr/share/man/man1/pakt-sync.1

# Config
install -vm 644 pakt.conf.default /etc/pakt.conf.default
cp -vn /etc/pakt.conf.default /etc/pakt.conf

echo -e "\nInstallation complete :)"
