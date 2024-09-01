#!/bin/sh

echo "Uninstalling pakt ..."

echo "Removing executable at /usr/bin/pakt ..."
rm /usr/bin/pakt

echo "Removing man pages ..."
rm /usr/share/man/man1/pakt.1
rm /usr/share/man/man1/pakt-sync.1

echo "Removing default config at /etc/pacman.conf.example ..."
rm /etc/pakt.conf.default

while true; do
	reap -p "Do you want to remove your config at /etc/pakt.conf? [Y/n]" response

	case "$response" in
		[Yy]|[Yy][Ee][Ss]|"")
			echo "Removing /etc/pakt.conf ..."
			rm /etc/pakt.conf
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

echo "Goodbye :["
