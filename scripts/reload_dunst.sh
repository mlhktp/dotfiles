#!/usr/bin/env bash
#
# Script to set colors generated by 'wal'
# https://github.com/dylanaraps/wal
 # Source generated colors.
. "${HOME}/.cache/wal/colors.sh"

killall -q dunst

DUNSTRC_FILE="$HOME/.config/dunst/dunstrc"

if [ ! -f "$DUNSTRC_FILE" ]; then
    echo "File '$DUNSTRC_FILE' not found!"
    exit 1
fi

# Remove the last 16 lines from the dunstrc file
head -n -12 "$DUNSTRC_FILE" > temp_file && mv temp_file "$DUNSTRC_FILE"

# Define new lines to add
cat <<EOL >> "$DUNSTRC_FILE"
[urgency_low]
    background = "${background}70"
    foreground = "${foreground}"
    timeout = 3
[urgency_normal]
    background = "${background}70"
    foreground = "${foreground}"
    timeout = 3
[urgency_critical]
    background = "${background}70"
    foreground = "${foreground}"
    timeout = 3
EOL

echo "Last 12 lines removed and new configuration added to '$DUNSTRC_FILE'."
