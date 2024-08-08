#!/bin/sh

# maybe there is a better approach, but this allows for easy use in if statement without [] aka test command, which results in problems
stringNotContain() { case $1 in *$2* ) return 1;; *) return 0;; esac ;}

if [ "$1" = "-h" ]; then
    echo "This will be the help page"
    exit
fi

if [ 2 -gt $# ]; then
    echo "You need at least 2 arguments. For Syntax see pacat -h ( not implemented yet ;) )"
    exit
fi


pth="$HOME/.local/share/pacat"
CAT="default"
CMD="pacman $1"
PAC=""
MODE=${1:1:1}
SYNC=0
PAC_INSTALLED=""

for ((i = 2; i <= $# ; i++));
do
    if [ ${!i} = "-c" ]; then
	  if [ $i -le $# ]; then
		((i++))
		echo
		CAT+=(${!i})
	  else
		echo "Syntax: -c ARG ; -c needs one argument!"
		exit
	  fi
	elif [ ${!i} = "-s" ]; then
		SYNC=1
    else
	  PAC+=(${!i})
    fi
done

for i in ${PAC[@]}; do
    CMD="$CMD $i"
done

# Execute pacman
if [ $SYNC -eq 0 ]; then
    sudo $CMD $PAC
    if [ "$?" -gt 0 ]; then
        echo "Pacman returned a fail. Exiting..."
		exit
	fi
else # -s, sync the packages
	PAC_DEL=$(sudo pacman -Qeq)
	PAC_BASE=$(sudo pacman -Qq)
	PAC_ADD=""
	# We want to combine all the categoriyfiles we got as parameter
	for c in ${CAT[@]}; do
		# We unfortunately have to do this for every entry in every categoryfile...
		while read -r p; do
			# PAC_DEL should include all packages implicitly installed on the system by the user that are not in the categoryfiles
			PAC_DEL=$(echo $PAC_DEL | tr ' ' '\n' | grep -v "^$p\$")
			# PAC_ADD should include all packages of the categoryfiles, that are not installed on the system
			if stringNotContain "$(echo $PAC_BASE | tr '\n' ' ')" " $p "; then
			 	PAC_ADD="${PAC_ADD} ${p}"
			fi
		done < "$pth/$c"
	done
	# We want to install/remove all the packages specified in the command as well
	if [ ! -z $PAC ] && [ $MODE[0] = "S" ]; then
		PAC_ADD="${PAC_ADD} ${p}"
	fi
	if [ ! -z $PAC ] && [ $MODE[0] = "R" ]; then
		PAC_DEL="${PAC_DEL} ${p}"
	fi
	# To be safe, we print the Packages to remove and install before calling pacman
	if [ ! -z $PAC_DEL ]; then
	   echo "Removing(dependencies not listed): $PAC_DEL"
	fi
	if [ ! -z $PAC_ADD ]; then
	   echo "Installing: $PAC_ADD"
	fi
	# Finally sync the packages
	# TODO Decide if sync should also do a full system upgrade.
	# This would also reduce the danger of partial upgrades/corrupt packages etc.
	if [ ! -z $PAC_DEL ]; then
	   sudo pacman -Rs $PAC_DEL
	fi
	if [ ! -z $PAC_ADD ]; then
	   sudo pacman -Sy $PAC_ADD
	fi
fi

# Create path if it doesnt exist
mkdir -p "$pth"
for f in ${CAT[@]}; do
    for p in ${PAC[@]}; do
	  case $MODE in
	  S) # Add Package
		# Check if Package is already in file, then dont add it
		if [ "$p" != "$(cat "$pth/$f" | grep "^$p\$")" ]; then
		    echo "$p" >> "$pth/$f"
		fi
	  ;;
	  R) # Remove Package
		sed -n "/^$p\$/"'!'"p" "$pth/$f" | tee "$pth/$f" > /dev/null # You cant pipe directly into pth/f bc the pipe is opened first, therefor the file is beeing cleared, therefor sed opens a empty file
	  ;;
	  esac
    done
done
