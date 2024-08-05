#!/bin/sh

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
    else
	  PAC+=(${!i})
    fi
done

for i in ${PAC[@]}; do
    CMD="$CMD $i"
done

# Execute pacman
sudo $CMD $PAC
if [ "$?" -gt 0 ]; then
    echo "Pacman returned a fail. Exiting..."
    exit
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
