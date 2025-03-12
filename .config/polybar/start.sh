#!/bin/bash
# remove if /tmp/cava.fifo exists
if [ -p /tmp/cava.fifo ]; then
    rm /tmp/cava.fifo
fi
pkill cava
pkill polybar

# i3-msg increase below gaps
i3-msg gaps bottom all plus 16%
polybar root --config=/home/melih/.config/polybar/config.ini &
polybar left --config=/home/melih/.config/polybar/config.ini &

# polybar title &
# polybar date &
# polybar dock &
