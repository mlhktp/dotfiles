#!/bin/bash

TERMINAL_CLASS="FloatingTerminal"
TERMINAL_CMD="/home/melih/.local/kitty.app/bin/kitty --class $TERMINAL_CLASS"
FLAG_FILE="/tmp/floating_terminal_flag"
WIDTH=800
HEIGHT=500

# Get screen dimensions
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 2)

# Calculate center position
POS_X=$(( (SCREEN_WIDTH / 2) - (WIDTH / 2) ))
POS_Y=$(( (SCREEN_HEIGHT / 2) - (HEIGHT / 2) ))

# Check if the terminal is running
TERMINAL_PID=$(pgrep -f "$TERMINAL_CMD")

if [[ -z "$TERMINAL_PID" ]]; then
    # Terminal is not running -> Launch it
    echo "Launching terminal"
    $TERMINAL_CMD &
    sleep 0.5
    i3-msg "[class=$TERMINAL_CLASS] floating enable, resize set $WIDTH $HEIGHT, move position $POS_X $POS_Y"
    echo "visible" > "$FLAG_FILE"
    exit 0
fi

# If terminal is running, check its flag state
if [[ -f "$FLAG_FILE" ]]; then
    STATE=$(cat "$FLAG_FILE")
else
    STATE="visible"
fi

if [[ "$STATE" == "visible" ]]; then
    # Hide terminal (send to scratchpad)
    echo "Hiding terminal"
    i3-msg "[class=$TERMINAL_CLASS] move scratchpad"
    echo "hidden" > "$FLAG_FILE"
elif [[ "$STATE" == "hidden" ]]; then
    # Show terminal from scratchpad
    echo "Restoring terminal"
    i3-msg "[class=$TERMINAL_CLASS] scratchpad show"
    echo "visible" > "$FLAG_FILE"
else
    # Unknown state, reset flag
    echo "visible" > "$FLAG_FILE"
fi
