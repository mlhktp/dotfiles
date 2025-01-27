#!/bin/bash

TERMINAL_CLASS="FloatingTerminal"
TERMINAL_CMD="/home/melih/.local/kitty.app/bin/kitty --class $TERMINAL_CLASS"
FLAG_FILE="/tmp/floating_terminal_flag"
WIDTH=800
HEIGHT=500

# Get screen information using xrandr
SCREEN_INFO=$(xrandr --query | grep " connected")

# Determine primary screen or fallback to the first screen
PRIMARY_SCREEN=$(echo "$SCREEN_INFO" | grep "primary" | awk '{print $4}')
if [[ -z "$PRIMARY_SCREEN" ]]; then
    PRIMARY_SCREEN=$(echo "$SCREEN_INFO" | head -n 1 | awk '{print $3}')
fi

# Extract width, height, and x/y offsets correctly
SCREEN_WIDTH=$(echo "$PRIMARY_SCREEN" | cut -d'x' -f1)
SCREEN_HEIGHT=$(echo "$PRIMARY_SCREEN" | cut -d'x' -f2 | cut -d'+' -f1)
OFFSET_X=$(echo "$PRIMARY_SCREEN" | cut -d'+' -f2)
OFFSET_Y=$(echo "$PRIMARY_SCREEN" | cut -d'+' -f3)

# Ensure offsets are set correctly (default to 0 if empty)
OFFSET_X=${OFFSET_X:-0}
OFFSET_Y=${OFFSET_Y:-0}

# Calculate center position relative to the primary screen
POS_X=$(( OFFSET_X + (SCREEN_WIDTH / 2) - (WIDTH / 2) ))
POS_Y=$(( OFFSET_Y + (SCREEN_HEIGHT / 2) - (HEIGHT / 2) ))

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
