#!/bin/sh

echo -e "Uninstalling pakt ...\n"

# Scripts
rm -v /usr/bin/pakt
rm -v /usr/bin/pakt-dry
rm -v /usr/bin/pakt-sync

# Manpages
rm -v /usr/share/man/man1/pakt.1.gz
rm -v /usr/share/man/man1/pakt-dry.1.gz
rm -v /usr/share/man/man1/pakt-sync.1.gz

# Default config
rm -v /etc/pakt.conf.default

# Config
while true; do
	read -p "Do you want to remove your config at /etc/pakt.conf? [Y/n] " response

	case "$response" in
		[Yy]|[Yy][Ee][Ss]|"")
			rm -v /etc/pakt.conf
			break
			;;
		[Nn]|[Nn][Oo])
			break
			;;
		*)
			echo "Invalid input. Please enter 'y' or 'n'."
			;;
	esac
done

echo -e "\nGoodbye :["
