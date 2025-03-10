#!/bin/bash
TERMINAL_CLASS="SmallFloatingTerminal"
if [ "$1" == "big" ]; then
   TERMINAL_CLASS="BigFloatingTerminal"
fi


TERMINAL_CMD="/home/melih/.local/kitty.app/bin/kitty --class $TERMINAL_CLASS"
FLAG_FILE="/tmp/${TERMINAL_CLASS}Flag"
# Check if the terminal is running
TERMINAL_PID=$(pgrep -f "$TERMINAL_CMD")

if [[ -z "$TERMINAL_PID" ]]; then
    # Terminal is not running -> Launch it
    echo "Launching terminal"
    $TERMINAL_CMD &
    # sleep 0.5
    # i3-msg "[class=$TERMINAL_CLASS] floating enable, resize set $WIDTH $HEIGHT, move position $POS_X $POS_Y"
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
