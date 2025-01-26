#!/bin/bash

BROWSER_CLASS="qutebrowser"  # Found using xprop
BROWSER_CMD="/home/melih/qutebrowser/.venv/bin/python3 -m qutebrowser --target window --desktop-file-name=FloatingQuteChatGPT https://chat.openai.com"
FLAG_FILE="/tmp/floating_chatgpt_flag"
WIDTH=800
HEIGHT=600

# Get screen dimensions
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 1)
SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f 2)

# Calculate center position
POS_X=$(( (SCREEN_WIDTH / 2) - (WIDTH / 2) ))
POS_Y=$(( (SCREEN_HEIGHT / 2) - (HEIGHT / 2) ))

# Check if qutebrowser ChatGPT window is running
BROWSER_PID=$(pgrep -f "qutebrowser.*chat.openai.com")

if [[ -z "$BROWSER_PID" ]]; then
    # ChatGPT window is not running -> Launch it
    echo "Launching ChatGPT in qutebrowser"
    $BROWSER_CMD &
    sleep 2
    i3-msg "[class=\"$BROWSER_CLASS\"] floating enable, resize set $WIDTH $HEIGHT, move position $POS_X $POS_Y"
    echo "visible" > "$FLAG_FILE"
    exit 0
fi

# If window is running, check its flag state
if [[ -f "$FLAG_FILE" ]]; then
    STATE=$(cat "$FLAG_FILE")
else
    STATE="visible"
fi

if [[ "$STATE" == "visible" ]]; then
    # Hide ChatGPT (send to scratchpad)
    echo "Hiding ChatGPT"
    i3-msg "[class=\"$BROWSER_CLASS\"] move scratchpad"
    echo "hidden" > "$FLAG_FILE"
elif [[ "$STATE" == "hidden" ]]; then
    # Show ChatGPT from scratchpad
    echo "Restoring ChatGPT"
    i3-msg "[class=\"$BROWSER_CLASS\"] scratchpad show"
    echo "visible" > "$FLAG_FILE"
else
    # Unknown state, reset flag
    echo "visible" > "$FLAG_FILE"
fi
