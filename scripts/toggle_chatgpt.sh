#!/bin/bash

BROWSER_CLASS="qutebrowser"  # Found using xprop
BROWSER_CMD="$HOME/qutebrowser/.venv/bin/python3 -m qutebrowser --target window --desktop-file-name=FloatingQuteChatGPT https://chat.openai.com"
FLAG_FILE="/tmp/floating_chatgpt_flag"

# Check if qutebrowser ChatGPT window is running
BROWSER_PID=$(pgrep -f "qutebrowser.*chat.openai.com")

if [[ -z "$BROWSER_PID" ]]; then
    # ChatGPT window is not running -> Launch it
    $BROWSER_CMD &
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
