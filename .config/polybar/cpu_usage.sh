#!/bin/bash

# Function to get average CPU usage
get_avg_cpu() {
    # top -bn2 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'
    mpstat | awk '$12 ~ /[0-9.]+/ { print 100 - $13 }'
}

# Function to get the application with highest CPU usage
get_top_app_usage() {
    # Get the top CPU consuming process with its percentage
    ps_output=$(ps aux --sort=-%cpu | awk 'NR==2 {print $3, $11}')
    
    # Extract percentage and app name
    percent=$(echo "$ps_output" | awk '{print $1}')
    app_name=$(echo "$ps_output" | awk '{print $2}' | awk -F/ '{print $NF}')
    
    # Check if we got valid data
    if [[ -z "$percent" || -z "$app_name" ]]; then
        echo "0.0 none"
    else
        echo "$percent $app_name"
    fi
}

# Get the values
avg_cpu=$(get_avg_cpu)
app_info=$(get_top_app_usage)
app_percent=$(echo "$app_info" | awk '{print $1}')
app_name=$(echo "$app_info" | awk '{print $2}')

# Format and print for polybar (with newline termination, which polybar expects)
printf "%.0f%%(%.0f%%)\n" $avg_cpu $app_percent
