#!/bin/bash

CONFIG_FILE="$HOME/.config/picom/picom.conf"

usage() {
    echo "Usage: $0 {toggle|enable|disable}"
    exit 1
}

toggle_opacity_rule() {
    if grep -q "^\s*opacity-rule" "$CONFIG_FILE"; then
        sed -i '/^\s*opacity-rule/,/^\s*]/ s/^/#/' "$CONFIG_FILE"
        echo "Transparency disabled."
    else
        sed -i '/^#\s*opacity-rule/,/^#\s*]/ s/^#//' "$CONFIG_FILE"
        echo "Transparency enabled."
    fi
}

enable_opacity_rule() {
    sed -i '/^#\s*opacity-rule/,/^#\s*]/ s/^#//' "$CONFIG_FILE"
    echo "Transparency enabled."
}

disable_opacity_rule() {
    sed -i '/^\s*opacity-rule/,/^\s*]/ s/^/#/' "$CONFIG_FILE"
    echo "Transparency disabled."
}

case "$1" in
    toggle) toggle_opacity_rule ;;
    enable) enable_opacity_rule ;;
    disable) disable_opacity_rule ;;
    *) usage ;;
esac
