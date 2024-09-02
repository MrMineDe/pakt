#!/bin/sh

echo "Uninstalling pakt ..."

echo "Removing executables at /usr/bin/pakt, /usr/bin/pakt-dry, /usr/bin/pakt-sync ..."
rm /usr/bin/pakt
rm /usr/bin/pakt-dry
rm /usr/bin/pakt-sync

echo "Removing man pages ..."
rm /usr/share/man/man1/pakt.1.gz
rm /usr/share/man/man1/pakt-dry.1.gz
rm /usr/share/man/man1/pakt-sync.1.gz

echo "Removing default config at /etc/pacman.conf.example ..."
rm /etc/pakt.conf.default

while true; do
	read -p "Do you want to remove your config at /etc/pakt.conf? [Y/n] " response

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
