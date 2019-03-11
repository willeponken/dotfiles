#!/usr/bin/env bash

# Fix Java
wmname LG3d
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
AWT_TOOLKIT=MToolkit; export AWT_TOOLKIT

# Some keyboard layout modifications
#setxkbmap -layout se -variant swolemak # Swedish Colemak layout
setxkbmap se
setxkbmap -option "ctrl:nocaps" # Use <CapsL> as <Ctrl>
xmodmap -e "keycode 49  = U03BE" # Remap § -> ξ

HOSTNAME=$(head -n 1 /etc/hostname); export HOSTNAME
if [ "${HOSTNAME,,}" = "hubble" ]; then
	xrandr --output HDMI-0 --primary --pos 1080x480 --auto \
	       --output DP-0.1 --pos 0x0 --rotate left --auto \
	       --output DP-0.2 --pos 3000x0 --rotate right --auto
fi

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
				slock # Blocks until unlocked.
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
