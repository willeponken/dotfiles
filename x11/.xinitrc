#!/usr/bin/env bash

# Fix Java
wmname LG3d
AWT_TOOLKIT=MToolkit; export AWT_TOOLKIT

# Fix git GPG signing
export GPG_TTY=$(tty)

# Some keyboard layout modifications
setxkbmap se # Swedish layout
setxkbmap -option altwin:swap_lalt_lwin # Swap <LAlt> and <Super>
setxkbmap -option "ctrl:nocaps" # Use <CapsL> as <Ctrl>

function lockscreen() {
	function displayoff() {
		sleep 1 && xset dpms force off
	}

	while true
	do
		if [ $(xssstate -s) != "disabled" ];
		then
			tosleep=$(($(xssstate -t) / 1000))
			if [ $tosleep -le 0 ];
			then
				displayoff &
				slock
			else
				sleep $tosleep
			fi
		else
			sleep 10
		fi
	done
}

slstatus &
lockscreen &
unclutter -jitter 10 -idle 1 -root &

dwm
