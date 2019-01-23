#!/usr/bin/env bash

# Fix Java
wmname LG3d
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
AWT_TOOLKIT=MToolkit; export AWT_TOOLKIT

# Some keyboard layout modifications
setxkbmap se # Swedish layout
setxkbmap -option altwin:swap_lalt_lwin # Swap <LAlt> and <Super>
setxkbmap -option "ctrl:nocaps" # Use <CapsL> as <Ctrl>
xmodmap -e "keysym onehalf = U03BE" # Remap § -> ξ

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
