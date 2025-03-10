echo "Installing system applications"
sudo pacman -S dunst picom polybar ranger rofi i3-wm ranger zathura
sudo pacman -S pulseaudio cpupower
sudo pacman -S xclip
sudo pacman -S python-pip base-devel git
sudo pacman -S ripgrep
sudo pacman -S stow
sudo pacman -S emacs

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install



mkdir -p /tmp/yay-install && cd /tmp/yay-install
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
rm -rf /tmp/yay-install

sudo pacman -S tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing applications used in scripts"
# vol.sh
sudo pacman -S playerctl libnotify
sudo pacman -S flameshot
mkdir -p /tmp/light-install && cd /tmp/light-install
git clone https://aur.archlinux.org/light.git
cd light
makepkg -si --noconfirm
cd ~
rm -rf /tmp/light-install

mkdir -p /tmp/google-chrome-install && cd /tmp/google-chrome-install
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si --noconfirm
cd ~
rm -rf /tmp/google-chrome-install

echo "Installing fonts"
sudo pacman -S ttf-firacode-nerd ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols

echo "Installing wallpaper and colorscheme applications"
sudo pacman -S python-pywal imagemagick feh nitrogen
echo "Installing wallpapers"
git clone https://github.com/saint-13/Linux_Dynamic_Wallpapers

echo "Setting wallpaper and colorscheme of the system"
export $WALL_PATH = /home/melih/Linux_Dynamic_Wallpapers/Dynamic_Wallpapers/ZorinBlur/afternoon.png
[ -f ~/.current_wallpaper ] && rm ~/.current_wallpaper
ln -sf "${WALL_PATH}" $HOME/.current_wallpaper
wal -s -i "${WALL_PATH}"

# betterlock screen and dependencies
sudo pacman -S autoconf cairo fontconfig gcc libev libjpeg-turbo libxinerama libxkbcommon-x11 libxrandr pam pkgconf xcb-util-image xcb-util-xrm
mkdir -p /tmp/i3lock-color-install && cd /tmp/i3lock-color-install
git clone https://aur.archlinux.org/i3lock-color.git
cd i3lock-color
makepkg -si
cd ~
rm -rf /tmp/i3lock-color-install

sudo pacman -S xorg-xdpyinfo xorg-xrandr xorg-xrdb xorg-xset
sudo pacman -S bc
wget https://raw.githubusercontent.com/betterlockscreen/betterlockscreen/main/install.sh -O - -q | sudo bash -s system

betterlockscreen -u "${WALL_PATH}"

echo "Installing kitty"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Installing zsh"
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat




## Add natural scrolling to touchpad
CONFIG_FILE="/etc/X11/xorg.conf.d/40-libinput.conf"
SEARCH_STRING='Option "NaturalScrolling" "true"'

# Ensure the directory exists
sudo mkdir -p /etc/X11/xorg.conf.d

# Check if the file already contains the NaturalScrolling option
if sudo grep -q "$SEARCH_STRING" "$CONFIG_FILE" 2>/dev/null; then
    echo "Natural Scrolling is already enabled in $CONFIG_FILE. No changes made."
else
    echo "Enabling Natural Scrolling..."
    
    # Append the configuration safely
    sudo tee "$CONFIG_FILE" > /dev/null <<EOL
Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "NaturalScrolling" "true"
EndSection
EOL

    echo "Configuration added successfully!"
fi


stow .


# Inform user to reboot for changes to take effect
echo "Please reboot your system for the changes to take effect."

