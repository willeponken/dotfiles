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
        nvidia-settings --load-config-only
        nvidia-settings --assign CurrentMetaMode="HDMI-0: nvidia-auto-select +1080+420, DP-0.1: nvidia-auto-select +0+0 {rotation=left}, DP-0.2: nvidia-auto-select +3000+0 {rotation=right}"

        # This is the price you have to pay for buying cheap monitors...
        xset -dpms
    fi

    dwm
done
