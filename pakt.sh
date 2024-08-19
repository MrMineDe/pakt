#!/bin/sh
# TODO /bin/sh is wip!

# maybe there is a better approach, but this allows for easy use in if statement without [] aka test command, which results in problems
stringNotContain() { case $1 in *$2* ) return 1;; *) return 0;; esac ;}

# TODO Change -h, as it is used by pacman!
if [ "$1" = "-h" ]; then
	echo "This will be the help page"
	exit
fi

pth="$HOME/.local/share/pacat"
CAT="default"
CMD="pacman"
PAC=""
MODE=""
SYNC=0

# This is used, to save the state of -C argument, to store the ARG after -C
DASH_C_TRUE=0
for A in "$@"; do
	if [ "$DASH_C_TRUE" -eq 1 ]; then
		CAT="${CAT} ${A}"
		DASH_C_TRUE=0
		continue;
	fi
	case "$A" in
		-*)
			case "$A" in
				*S*)
					MODE="S"
					ARG="${ARG} ${A}" #${!i}"
				;;
				*R*)
					MODE="R"
					ARG="${ARG} ${A}"
				;;
				# TODO Add -Q capability
				"-C")
					# We want to store the argument after -C, so we set a variable that will store the next element and then skip to the next word
					DASH_C_TRUE=1
				;;
				# TODO change this to smth, that resembles sync, but is not taken by pacman
				"-ABC")
					SYNC=1
				;;
				*)
					ARG="${ARG} ${A}"
				;;
			esac
		;;
		*)
			# TODO is there anything that is not started with - but still no package?
			PAC="${PAC} ${A}"
		;;
	esac
	i="$((i+1))"
done
# If -C is the last argument, throw an error!
if [ "$DASH_C_TRUE" -eq 1 ]; then
	echo "Syntax: -C ARG ; -C needs one argument! See pakt -h for more info"
	exit
fi

# Execute pacman
if [ $SYNC -eq 0 ]; then
	if ! sudo $CMD $ARG $PAC; then
		echo "Pacman returned a fail. Exiting..."
		exit
	fi
else # -s, sync the packages
	PAC_DEL=$(sudo $CMD -Qeq)
	PAC_BASE=$(sudo $CMD -Qq)
	PAC_ADD=""
	# We want to combine all the categoriyfiles we got as parameter
	for c in $CAT; do
		# We unfortunately have to do this for every entry in every categoryfile...
		while read -r p; do
			# PAC_DEL should include all packages implicitly installed on the system by the user that are not in the categoryfiles
			PAC_DEL=$(echo "$PAC_DEL" | tr ' ' '\n' | grep -v "^$p\$")
			# PAC_ADD should include all packages of the categoryfiles, that are not installed on the system
			if stringNotContain "$(echo "$PAC_BASE" | tr '\n' ' ')" " $p "; then
				PAC_ADD="${PAC_ADD} ${p}"
			fi
		done < "$pth/$c"
	done
	# We convert spaces to new lines for grep a few lines ago, for pacman we need to reverse that
	PAC_DEL=$(echo "$PAC_DEL" | tr '\n' ' ')
	# We want to install/remove all the packages specified in the command as well
	# TODO This does not work as intended atm
	if [ -n "$PAC" ] && [ "$MODE" = "S" ]; then
		PAC_ADD="${PAC_ADD} ${PAC}"
	fi
	if [ -n "$PAC" ] && [ "$MODE" = "R" ]; then
		PAC_DEL="${PAC_DEL} ${PAC}"
	fi
	# To be safe, we print the Packages to remove and install before calling pacman
	if [ -n "$PAC_DEL" ]; then
		echo "Removing(dependencies not listed): $PAC_DEL"
	fi
	if [ -n "$PAC_ADD" ]; then
		echo "Installing: $PAC_ADD"
	fi
	# Finally sync the packages
	# TODO Decide if sync should also do a full system upgrade.
	# This would also reduce the danger of partial upgrades/corrupt packages etc.
	if [ -n "$PAC_DEL" ]; then
		if ! sudo pacman -Rs $PAC_DEL; then
			echo "Pacman returned a fail. Exiting..."
			exit
		fi
	fi
	if [ -n "$PAC_ADD" ]; then
		if ! sudo pacman -Sy $PAC_ADD; then
			echo "Pacman returned a fail. Exiting..."
			exit
		fi
	fi
fi

# Create path if it doesnt exist
mkdir -p "$pth"
for f in $CAT; do
	for p in $PAC; do
		case $MODE in
			S) # Add Package
				# Check if Package is already in file, then dont add it
				if [ "$p" != "$(grep "^$p\$" "$pth/$f")" ]; then
					echo "$p" >> "$pth/$f"
				fi
				;;
			R) # Remove Package
				sed -n "/^$p\$/"'!'"p" "$pth/$f" | tee "$pth/$f" > /dev/null # You cant pipe directly into pth/f bc the pipe is opened first, therefor the file is beeing cleared, therefor sed opens a empty file
				;;
		esac
	done
done
