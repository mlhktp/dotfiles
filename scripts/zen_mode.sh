#!/bin/bash

# Path to your Picom config
PICOM_CONFIG=~/.config/picom/picom.conf

POLYBAR_PROCESS="polybar"
# Check if Zen Mode is enabled
if [ -f /tmp/zen_mode ]; then
    # Disable Zen Mode
    rm /tmp/zen_mode
    # Restore default gaps
    i3-msg gaps inner all set 10
    i3-msg gaps outer all set 10
    # Restore Picom settings
    sed -i '/^corner-radius =/c\corner-radius = 15' $PICOM_CONFIG
    sed -i '/^round-borders =/c\round-borders = 15' $PICOM_CONFIG
    sed -i '/^fading =/c\fading = true' $PICOM_CONFIG
    sed -i '/^inactive-opacity =/c\inactive-opacity = 1' $PICOM_CONFIG
    sed -i '/^active-opacity =/c\active-opacity = 1' $PICOM_CONFIG
    picom --experimental-backends --config $PICOM_CONFIG -b &
    i3-msg restart
    notify-send "Zen Mode" "Zen Mode disabled."
else
    # Enable Zen Mode
    touch /tmp/zen_mode
    # Remove gaps
    i3-msg gaps inner all set 0
    i3-msg gaps outer all set 0
    # Update Picom settings
    sed -i '/^corner-radius =/c\corner-radius = 0' $PICOM_CONFIG
    sed -i '/^round-borders =/c\round-borders = 0' $PICOM_CONFIG
    sed -i '/^fading =/c\fading = false' $PICOM_CONFIG
    sed -i '/^inactive-opacity =/c\inactive-opacity = 1' $PICOM_CONFIG
    sed -i '/^active-opacity =/c\active-opacity = 1' $PICOM_CONFIG
    pkill picom
    if pgrep -x "$POLYBAR_PROCESS" > /dev/null; then
        killall -q "$POLYBAR_PROCESS"
    fi
    notify-send "Zen Mode" "Zen Mode enabled."
fi

# Notify user

