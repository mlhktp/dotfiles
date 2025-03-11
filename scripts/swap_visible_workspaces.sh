#!/bin/bash

# Get workspace data from i3
workspaces=$(i3-msg -t get_workspaces)

# Extract visible workspaces for each monitor
left_monitor="HDMI-A-0"
right_monitor="DisplayPort-0"

left_workspace=$(echo "$workspaces" | jq -r '.[] | select(.visible == true and .output == "'"$left_monitor"'") | .name')
right_workspace=$(echo "$workspaces" | jq -r '.[] | select(.visible == true and .output == "'"$right_monitor"'") | .name')

# Swap them if both exist
if [[ -n "$left_workspace" && -n "$right_workspace" ]]; then
    i3-msg "workspace $left_workspace; move workspace to output $right_monitor"
    i3-msg "workspace $right_workspace; move workspace to output $left_monitor"
fi
