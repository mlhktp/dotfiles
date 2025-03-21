#!/bin/bash

PARENT_DIR=~/Linux_Dynamic_Wallpapers/Dynamic_Wallpapers

# Show directories with previews of their first image
THEME_DIR=$(for dir in "$PARENT_DIR"/*; do
    [ -d "$dir" ] || continue
    first_image=$(find "$dir" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | head -n 1)
    dir_name=$(basename "$dir")
    if [ -n "$first_image" ]; then
        echo -en "$dir_name\0icon\x1f$first_image\n"
    fi
done | rofi -dmenu -p "Select Theme Directory" -theme ~/.config/rofi/themechanger.rasi)

# Validate the selected directory
if [ -z "$THEME_DIR" ]; then
    notify-send "Wallpaper" "No theme directory selected."
    exit 1
fi

THEME_PATH="$PARENT_DIR/$THEME_DIR"

# Check if the directory exists
if [ ! -d "$THEME_PATH" ]; then
    notify-send "Wallpaper" "Selected directory does not exist."
    exit 1
fi

# Generate a list of images with preview and formatted names in the selected directory
WALL_NAME=$(for img in "$THEME_PATH"/*.{png,jpg,jpeg}; do
    [ -e "$img" ] || continue
    img_name=$(basename "$img")
    img_name_no_ext=${img_name%.*}
    echo -en "${img_name_no_ext^^}\0icon\x1f$img\n"
done | rofi -dmenu -p "Select Wallpaper" -theme ~/.config/rofi/themechanger.rasi)

# Validate the selected image
if [ -z "$WALL_NAME" ]; then
    notify-send "Wallpaper" "No wallpaper selected."
    exit 1
fi

# Find the selected image's full path
WALL_PATH=$(find "$THEME_PATH" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) -iname "${WALL_NAME,,}.*" | head -n 1)

if [ -z "$WALL_PATH" ]; then
    notify-send "Wallpaper" "No wallpaper found for the selected name."
    exit 1
fi

# Apply the selected wallpaper
wal -s -i "${WALL_PATH}"

# Update the symbolic link to the current wallpaper
[ -f ~/.current_wallpaper ] && rm ~/.current_wallpaper
ln -sf "${WALL_PATH}" $HOME/.current_wallpaper


# Reload other applications
# bash ~/scripts/wal_to_alacritty.sh ~/.config/alacritty/alacritty.toml
# bash ~/scripts/reload_conky.sh
# bash ~/scripts/reload_obsidian.sh "$HOME/Notes"

POLYBAR_PROCESS="polybar"
if pgrep -x "$POLYBAR_PROCESS" > /dev/null; then
    polybar-msg cmd hide &
    killall -q "$POLYBAR_PROCESS"
fi

i3-msg gaps bottom all set 9

exec bash /home/melih/.config/polybar/start.sh > /dev/null 2>&1 &

bash ~/scripts/reload_dunst.sh
# Notify the user
betterlockscreen -u "${WALL_PATH}"
notify-send "Wallpaper" "Wallpaper set to ${WALL_NAME}"

