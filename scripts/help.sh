#!/bin/bash

TERMINAL_CLASS="HelpFloatingTerminal"
WIDTH=800
HEIGHT=700

TERMINAL_CMD="/home/melih/.local/kitty.app/bin/kitty --class $TERMINAL_CLASS"

# ANSI Color Codes
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
MAGENTA='\033[1;35m'
GRAY='\033[0;90m'
RESET='\033[0m'

# Define help text with ANSI colors
HELP_TEXT="
$(tput civis)
${YELLOW}
               ╔══════════════════════════════════════╗
               ║             i3 Keybindings           ║
               ╚══════════════════════════════════════╝
${RESET}

${CYAN}     Mod+Enter                    ${WHITE} Open terminal
${CYAN}     Mod+d                        ${WHITE} Open application launcher (rofi)
${CYAN}     Mod+Shift+q                  ${WHITE} Open power menu
${CYAN}     Mod+q                        ${WHITE} Close window
${CYAN}     Mod+h/j/k/l                  ${WHITE} Move focus left/down/up/right
${CYAN}     Mod+Shift+h/j/k/l            ${WHITE} Move window left/down/up/right
${CYAN}     Mod+f                        ${WHITE} Toggle fullscreen
${CYAN}     Mod+space                    ${WHITE} Toggle floating mode
${CYAN}     Mod+1-9                      ${WHITE} Switch to workspace 1-9
${CYAN}     Mod+Shift+1-9                ${WHITE} Move window to workspace 1-9
${CYAN}     Mod+Shift+e                  ${WHITE} Exit i3

${GRAY}     ───────────────────────────────────────────────────────────────${RESET}
${MAGENTA}     (Press 'q' or 'Esc' to close)${RESET}
"

# Launch kitty and display help text with hidden cursor
$TERMINAL_CMD --override font_size=12 -e bash -c "
  tput civis;  # Hide cursor
  echo -e \"$HELP_TEXT\";
  read -n 1;
  tput cnorm  # Restore cursor
" &

# Wait for kitty to fully open before applying i3 rules
sleep 0.5

# Move and resize the help window
i3-msg "[class=$TERMINAL_CLASS] floating enable, resize set $WIDTH $HEIGHT, move position center"

