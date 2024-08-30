#!/bin/sh

echo "Uninstalling pakt ..."

echo "Removing executable at /usr/bin/pakt ..."
rm /usr/bin/pakt

echo "Removing default config at /etc/pacman.conf.example ..."
rm /etc/pakt.conf.example

echo "NOTE: ~/.config/pakt still exists!"

echo "Goodbye :["
