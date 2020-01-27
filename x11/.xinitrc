#!/usr/bin/env bash

# Fix Java
wmname LG3d
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
AWT_TOOLKIT=MToolkit; export AWT_TOOLKIT

export BROWSER=firefox
HOSTNAME=$(head -n 1 /etc/hostname); export HOSTNAME

function lockscreen() {
    function displayoff() {
        sleep 1 && xset dpms force off
    }

    while true
    do
        if [ "$(xssstate -s)" != "disabled" ];
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

while true; do
    # Some keyboard layout modifications
    setxkbmap -layout us altgr-intl # US international (w/ altgr)
    setxkbmap -option ctrl:nocaps # Use <CapsL> as <Ctrl>
    setxkbmap -option altwin:swap_lalt_lwin # Swap <AltL> and <SuperL>.
    setxkbmap -option compose:prsc # Set <PrtSc> as <Compose>.
    setxkbmap -option compose:rwin # Set <WinR> as <Compose>.

    # Setup multi head for Hubble
    if [ "${HOSTNAME}" = "hubble" ]; then
        xrandr --output HDMI-0 --off \
            --output DP-0.1 --off \
            --output DP-0.2 --off
        xrandr --output HDMI-0 --primary --pos 1080x480 --auto \
            --output DP-0.1 --left-of HDMI-0 --pos 0x0 \
            --rotate left --auto \
            --output DP-0.2 --right-of HDMI-0 --pos 3000x0 \
            --rotate right --auto
    fi
    dwm
done
