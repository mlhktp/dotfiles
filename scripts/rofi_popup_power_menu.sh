#!/usr/bin/env bash

OPTIONS=("   Reboot system" "   Power-off system" "   Suspend system" "   Hibernate system" "   Lock system" "   Exit window manager")

LAUNCHER="rofi -dmenu -i -p PowerPopup -theme $HOME/.config/rofi/popupmenu.rasi --normal-window --window-class RofiPopupPowerMenu"
USE_LOCKER="true"
LOCKER="betterlockscreen -l"

option=$()

option=$(printf "%s\n" "${OPTIONS[@]}" | $LAUNCHER)
case $option in
  "   Exit window manager")
    i3-msg exit
    ;;
  "   Reboot system")
    systemctl reboot
    ;;
  "   Power-off system")
    systemctl poweroff
    ;;
  "   Suspend system")
    $($USE_LOCKER) && "$LOCKER"; systemctl suspend
    ;;
  "   Hibernate system")
    $($USE_LOCKER) && "$LOCKER"; systemctl hibernate
    ;;
  "   Lock system")
  $LOCKER
  ;;
  *)
    ;;
esac
