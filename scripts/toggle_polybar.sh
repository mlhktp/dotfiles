#!/bin/bash

# Polybar launch script

# Define the name of your polybar process
POLYBAR_PROCESS="polybar"

# Check if Polybar is running
if pgrep -x "$POLYBAR_PROCESS" > /dev/null; then
    killall -q "$POLYBAR_PROCESS"
else
    exec bash /home/melih/.config/polybar/start.sh > /dev/null 2>&1 &
fi

