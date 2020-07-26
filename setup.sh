#!/usr/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get clean
sudo add-apt-repository universe
sudo add-apt-repository multiverse

sudo apt-get install -y \
	build-essential python3 python3-setuptools unzip \
	ubuntu-restricted-extras flatpak

flatpak remote-add --if-not-exists \
	flathub https://flathub.org/repo/flathub.flatpakrepo

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env


# Desktop

# Plymouth - loading (splash) screen
# SLiM - display manager
# X11 — display server
# Openbox — window manager
# obconf — openbox configuration GUI
# Nitrogen — wallpapers manager
# Dunst — notifications
# Rofi — window switcher, application launcher and dmenu replacement
# Compton — compositor, for shadows and opacity
# LXAppearance - GTK settings
# LXInput - keyboard and mouse settings
# LXRandr - monitor settings
# MPD - music player daemon
# XFCE4 Panel - dock
sudo apt-get install -y plymouth-x11 plymouth-themes slim xorg openbox obconf nitrogen dunst rofi \
compton compton-conf lxappearance lxinput lxrandr xfce4-panel mpd xbacklight acpi

# if you wish a Debian apps submenu in the desktop menu,
# uncomment the below block
# sudo apt-get install -y menu
# mkdir -p ~/.config/openbox
# cp /etc/X11/openbox/menu.xml ~/.config/openbox/menu.xml
# cp /etc/X11/openbox/rc.xml ~/.config/openbox/rc.xml
# openbox --reconfigure

# touchbar support and gestures settings app
sudo gpasswd -a $USER input
su - ${USER}
sudo apt-get install -y \
	libinput-tools xdotool wmctrl python3-gi python-gobject \
	gobject-introspection gir1.2-gtk-3.0
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
sudo make install
cd ..
rm -rf libinput-gestures
libinput-gestures-setup autostart
libinput-gestures-setup start
git clone https://gitlab.com/cunidev/gestures
cd gestures
sudo python3 setup.py install
cd ..
rm -rf gestures

# Polybar 3.4.3 — status bar
sudo apt-get install -y \
  cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
  libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev \
  libxcb-util0-dev libxcb-xkb-dev pkg-config python3-xcbgen \
  xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev \
  libiw-dev libcurl4-openssl-dev libpulse-dev \
  libxcb-composite0-dev xcb libxcb-ewmh2 wireless-tools

git clone https://github.com/jaagr/polybar.git
cd polybar
git checkout 3.4.3
./build.sh
cd ..
rm -rf polybar

sudo timedatectl set-timezone Europe/Minsk

# Applications

# Thunar - file manager
# Nomacs - image viewer and browser
sudo apt-get install -y thunar nomacs
# Telegram - messenger
# Opera - internet browser
sudo snap install telegram-desktop opera
# Alacritty - terminal emulator
git clone https://gist.github.com/cc8cb59f6d5a1aa95512e81e3dfe64ff.git install_alacritty
cd install_alacritty/
chmod +x install-alacritty-ubuntu.sh
./install-alacritty-ubuntu.sh
cd ..
rm -rf install_alacritty


# Themes

# SLiM theme
git clone https://github.com/adi1090x/slim_themes.git
sudo mv slim_themes/themes/* /usr/share/slim/themes/
sudo rm -rf slim_themes
sudo rm /etc/slim.conf
sudo mv /config/slim/slim.conf /etc/

# icons
sudo add-apt-repository ppa:daniruiz/flat-remix
sudo apt-get update -y
sudo apt-get install flat-remix
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update -y
sudo apt-get install -y papirus-icon-theme
sudo apt-get install breeze-icon-theme

# openbox themes
mdkir ~/.themes
git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes
rm -rf ~/.themes/.git
git clone https://github.com/fikriomar16/OBTheme-Collections.git
mv OBTheme-Collections/* ~/.themes/
rm -rf OBTheme-Collections

# gtk themes
rm -rf ~/.themes/.git
git clone https://github.com/addy-dclxvi/gtk-theme-collections 
mv gtk-theme-collections/* ~/.themes/
rm -rf gtk-theme-collections
wget https://github.com/EliverLara/Sweet/releases/download/v1.10.5/Sweet.zip
wget https://github.com/EliverLara/Sweet/releases/download/v1.10.5/Sweet-Ambar-Blue.zip
wget https://github.com/EliverLara/Sweet/releases/download/v1.10.5/Sweet-Ambar.zip
wget https://github.com/EliverLara/Sweet/releases/download/v1.10.5/Sweet-Dark.zip
wget https://github.com/EliverLara/Sweet/releases/download/v1.10.5/Sweet-mars.zip
unzip "Sweet*.zip" -d ~/.themes/
rm -f Sweet*.zip

# polybar theme
git clone https://github.com/adi1090x/polybar-themes.git
cd polybar-themes/polybar-12
sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf # enable bitmap fonts
mkdir -p ~/.local/share/fonts
mkdir -p ~/.config/polybar
cp -r fonts/* ~/.local/share/fonts
cd ../polybar-11
cp -r fonts/* ~/.local/share/fonts
cd -
fc-cache -fv
cp -r * ~/.config/polybar
cd ../..
rm -rf polybar-themes

# plymouth theme
git clone https://github.com/adi1090x/plymouth-themes.git
cd plymouth-themes/pack_4
sudo cp -r rings_2 /usr/share/plymouth/themes/
cd ../..
rm -rf plymouth-themes
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/rings_2/rings_2.plymouth 100
sudo update-alternatives --config default.plymouth
sudo update-initramfs -u
sudo rm /etc/default/grub
sudo mv config/grub/grub /etc/default/
sudo update-grub

# rofi-related
# fonts
sudo apt-get install -y fonts-comfortaa fonts-noto fonts-fantasque-sans
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
chmod +x install.sh
./install.sh
cd ..
rm -rf nerd-fonts
wget https://github.com/adi1090x/rofi/raw/master/fonts/feather.ttf
wget https://github.com/be5invis/Iosevka/releases/download/v3.3.1/ttf-iosevka-3.3.1.zip
mv feather.ttf ~/.local/share/fonts/
unzip ttf-iosevka-3.3.1.zip -d ~/.local/share/fonts/
rm -f ttf-iosevka-3.3.1.zip
sudo fc-cache -fv
# widgets
mkdir -p ~/.config/rofi
cd ~/.config/rofi
git clone https://github.com/adi1090x/rofi.git
cd rofi && chmod +x scripts/*
cp -r bin scripts themes config.rasi ~/.config/rofi
cd .. && rm -rf rofi

# dwal - dynamic wallpapers
sudo apt-get install -y x11-xserver-utils feh
git clone https://github.com/adi1090x/dynamic-wallpaper.git
cd dynamic-wallpaper
chmod +x install.sh
./install.sh
cd ..
rm -rf dynamic-wallpaper


# Autostart
mv config/autostart ~/.config/openbox/


# Clean up

# remove gdm3 display manager
sudo apt-get autoremove -y gdm3

# remove everything gnome-related
sudo apt-get purge -y gnome*
sudo apt-get autoremove -y

# reinstall gnome terminal
sudo apt-get install -y gnome-terminal


# Done

sudo reboot
