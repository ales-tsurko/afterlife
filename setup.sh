#!/bin/bash

set -e

# Desktop

# Plymouth - loading (splash) screen
# menumaker - menu rebuilder for openbox
# dunst - notifications
# picom - compositor, for shadows and opacity
# compton-conf - compton settings
# Tint2 - dock
# LXAppearance - GTK settings
# obconf - openbox settings
# LXInput - keyboard and mouse settings
# LXRandr - monitor settings
# polybar - status bar
# unzip - extracting zip archives
# connman - network manager
# pass - passwords management
# seahorse - gnome-keyring gui
# xorg-xbacklight - changing screen brightness
# xf86-video-intel - video driver
# ufw - cli for firewall configuration
# gufw - iptables frontend (gui for ufw)
# manjaro-settings-manager
# manjaro-settings-manager-notifier
# qt5ct - qt configuration utility
sudo pacman -Syu --noconfirm plymouth menumaker dunst picom tint2 \
	lxappearance obconf lxinput lxrandr compton-conf polybar unzip \
	libinput-gestures gestures libinput xf86-input-libinput connman \
	pass libsecret seahorse xorg-xbacklight acpi xf86-video-intel \
	intltool ufw gufw manjaro-settings-manager \
	manjaro-settings-manager-notifier qt5ct

# touchpad settings
# rofi - window switcher, application launcher and dmenu replacement
# connman-gtk - connman gui
yay -Syu --noconfirm gpointing-device-settings rofi-git connman-gtk


# Apps

# neovim - editor
# termite - terminal emulator
sudo pacman -Syu --noconfirm neovim python-pynvim termite


# Themes

# fonts
sudo pacman -Syu --noconfirm noto-fonts ttf-comfortaa ttf-fantasque-sans-mono
yay -Syu --noconfirm ttf-mac-fonts ttf-ms-fonts
mkdir -p ~/.fonts

mkdir -p nerd_fonts && cd nerd_fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hermit.zip
unzip "*.zip" -d ~/.fonts/
cd .. && rm -rf nerd_fonts

wget https://github.com/adi1090x/rofi/raw/master/fonts/feather.ttf
wget https://github.com/be5invis/Iosevka/releases/download/v3.3.1/ttf-iosevka-3.3.1.zip
mv feather.ttf ~/.fonts/
unzip ttf-iosevka-3.3.1.zip -d ~/.fonts/
rm -f ttf-iosevka-3.3.1.zip

sudo fc-cache -fv
fc-cache -fv

# icons
yay -Syu --noconfirm flat-remix flat-remix-gtk
sudo pacman -Syu --noconfirm papirus-icon-theme breeze-icons breeze-gtk

# openbox
mkdir -p ~/.themes
git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes
rm -rf ~/.themes/.git
git clone https://github.com/fikriomar16/OBTheme-Collections.git
mv OBTheme-Collections/* ~/.themes/
rm -rf OBTheme-Collections

# gtk
sudo pacman -Syu --noconfirm gtk-engines breeze-gtk 
yay -Syu --noconfirm flat-remix-gtk

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

wget -c https://github.com/Jannomag/Yaru-Colors/releases/download/20.04.5/Complete-Yaru-Colors-20.04.5.tar.xz
tar -xf Complete-Yaru-Colors-20.04.5.tar.xz -C ~/.themes/
rm -f Complete-Yaru-Colors-20.04.5.tar.xz
mv ~/.themes/Themes/* ~/.themes/
rm -rf ~/.themes/Themes

git clone https://github.com/vinceliuice/Layan-gtk-theme.git
cd Layan-gtk-theme
chmod +x install.sh
./install.sh
cd .. && rm -rf Layan-gtk-theme

git clone https://github.com/vinceliuice/Qogir-theme.git
cd Qogir-theme
chmod +x install.sh
./install.sh
cd .. && rm -rf Qogir-theme

git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
chmod +x install.sh
./install.sh
cd .. && rm -rf Orchis-theme

# polybar
git clone https://github.com/adi1090x/polybar-themes.git
cd polybar-themes/polybar-12
cp -r fonts/* ~/.fonts
cd ../polybar-11
cp -r fonts/* ~/.fonts
cd -
fc-cache -fv
cd ../..
rm -rf polybar-themes

# plymouth theme
yay -Syu --noconfirm plymouth-theme-colorful-git
sudo plymouth-set-default-theme -l
sudo plymouth-set-default-theme -R colorful

# dwal - dynamic wallpapers
sudo pacman -Syu --noconfirm xorg-xrandr feh
git clone https://github.com/adi1090x/dynamic-wallpaper.git
cd dynamic-wallpaper
chmod +x install.sh
./install.sh
cd ..
rm -rf dynamic-wallpaper

# termite
git clone https://github.com/adi1090x/termite-style
cd termite-style
./install
cd .. && rm -rf termite-style


# Configs

# gtk
sudo rm -f /etc/gtk-2.0/gtkrc
sudo rm -f /etc/gtk-3.0/settings.ini
rm -f /usr/share/gtk-2.0/gtkrc
rm -f /usr/share/gtk-3.0/settings.ini
rm -rf ~/.config/gtk-2.0
rm -rf ~/.config/gtk-3.0
cp config/gtk-2.0/gtkrc /usr/share/gtk-2.0/
cp config/gtk-3.0/settings.ini /usr/share/gtk-3.0/
sudo cp config/gtk-2.0/gtkrc /etc/gtk-2.0/
sudo cp config/gtk-3.0/settings.ini /etc/gtk-3.0/
mv config/gtk-2.0 ~/.config/
mv config/gtk-3.0 ~/.config/

# qt5
touch ~/.profile
echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' >> ~/.profile

# lightdm
sudo mkdir -p /etc/lightdm && sudo rm -f /etc/lightdm/lightdm-gtk-greeter.conf
sudo mv config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/

# openbox
rm -rf ~/.config/openbox
mkdir -p ~/.config
mv config/openbox ~/.config/

# tint2
rm -rf ~/.config/tint2 && mv config/tint2 ~/.config/

# rofi
rm -rf ~/.config/rofi
mv config/rofi ~/.config/

# polybar
mv config/polybar ~/.config/
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/tester.sh
chmod +x ~/.config/polybar/scripts/*

# grub
sudo rm /etc/default/grub
sudo mv config/grub/grub /etc/default/
sudo update-grub

# termite
rm -rf ~/.config/termite
mv config/termite ~/.config/

# startup notes
mkdir -p ~/Desktop
mv extra/notes.md ~/Desktop/

# vconsole
sudo rm -f /etc/vconsole.conf

# dunst
mkdir -p ~/.config/dunst
sudo mv config/dunst/dunstrc ~/.config/dunst

# git (use gnome keyring)
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

# network manager
sudo rm -f /etc/connman/main.conf
sudo mv config/connman/main.conf /etc/connman/
systemctl enable connman.service
systemctl start connman.service

# firewall
systemctl enable ufw.service
systemctl start ufw.service
sudo ufw enable

# pacman
sudo rm -f /etc/pacman.conf
sudo cp config/pacman/pacman.conf /etc/ 

# gestures
sudo gpasswd -a $USER input
sudo -i -u $USER bash << EOF
EOF
libinput-gestures-setup autostart
libinput-gestures-setup start


# rebuild openbox menu
mmaker -v OpenBox3


# clean up
sudo pacman -Rs $(pacman -Qdtq)


# Done

sudo reboot
