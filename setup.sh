#!/bin/bash

set -e

# Desktop

# Plymouth - loading (splash) screen
# menumaker - menu rebuilder for openbox
# dunst - notifications
# Rofi - window switcher, application launcher and dmenu replacement
# picom - compositor, for shadows and opacity
# compton-conf - compton settings
# Tint2 - dock
# LXAppearance - GTK settings
# obconf - openbox settings
# LXInput - keyboard and mouse settings
# LXRandr - monitor settings
# polybar - status bar
# unzip - extracting zip archives
sudo pacman -S --noconfirm plymouth menumaker dunst rofi picom tint2 \
	lxappearance obconf lxinput lxrandr compton-conf polybar unzip \
	libinput-gestures gestures

# touchpad settings
yay -S --noconfirm gpointing-device-settings


# Apps

# neovim - editor
# thunar - file browser
# nomacs - image viewer
# alacritty - terminal emulator
# telegram - messenger
# chromium - web browser
sudo pacman -S --noconfirm neovim python-pynvim thunar nomacs alacritty \
	telegram-desktop chromium

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env


# Themes

# fonts
sudo pacman -S --noconfirm noto-fonts ttf-comfortaa ttf-fantasque-sans-mono
yay -S --noconfirm ttf-mac-fonts ttf-ms-fonts
mkdir -p ~/.fonts

mkdir -p nerd_fonts && cd nerd_fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FantasqueSansMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraMono.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip
unzip "*.zip" -d ~/.fonts/
cd .. && rm -rf nerd_fonts

wget https://github.com/adi1090x/rofi/raw/master/fonts/feather.ttf
wget https://github.com/be5invis/Iosevka/releases/download/v3.3.1/ttf-iosevka-3.3.1.zip
mv feather.ttf ~/.fonts/
unzip ttf-iosevka-3.3.1.zip -d ~/.fonts/
rm -f ttf-iosevka-3.3.1.zip

sudo fc-cache -fv

# icons

yay -S --noconfirm flat-remix flat-remix-gtk
sudo pacman -S --noconfirm papirus-icon-theme breeze-icons breeze-gtk

# openbox
mkdir -p ~/.themes
git clone https://github.com/addy-dclxvi/openbox-theme-collections ~/.themes
rm -rf ~/.themes/.git
git clone https://github.com/fikriomar16/OBTheme-Collections.git
mv OBTheme-Collections/* ~/.themes/
rm -rf OBTheme-Collections

# gtk
sudo pacman -S --noconfirm gtk-engines breeze-gtk 
yay -S --noconfirm flat-remix-gtk

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

rm -rf ~/.config/gtk-3.0
mv config/gtk-3.0 ~/.config/

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
yay -S --noconfirm plymouth-theme-colorful-git
sudo plymouth-set-default-theme -l
sudo plymouth-set-default-theme -R colorful

# rofi
mkdir -p ~/.config/rofi
git clone https://github.com/adi1090x/rofi.git
cd rofi && chmod +x scripts/*
cp -r bin scripts themes config.rasi ~/.config/rofi
cd .. && rm -rf rofi

# dwal - dynamic wallpapers
sudo pacman -S --noconfirm xorg-xrandr feh
git clone https://github.com/adi1090x/dynamic-wallpaper.git
cd dynamic-wallpaper
chmod +x install.sh
./install.sh
cd ..
rm -rf dynamic-wallpaper


# Configs

# lightdm
sudo mkdir -p /etc/lightdm && sudo rm -f /etc/lightdm/lightdm-gtk-greeter.conf
sudo mv config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/

# openbox
rm -rf ~/.config/openbox
mkdir -p ~/.config
mv config/openbox ~/.config/

# tint2
rm -rf ~/.config/tint2 && mv config/tint2 ~/.config/

# polybar
mv config/polybar ~/.config/
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/polybar/tester.sh
chmod +x ~/.config/polybar/scripts/*

# grub
sudo rm /etc/default/grub
sudo mv config/grub/grub /etc/default/
sudo update-grub

# alacritty
rm -rf ~/.alacritty.yml
mv config/alacritty/.alacritty.yml ~/

# startup notes
mkdir -p ~/Desktop
mv extra/notes.md ~/Desktop/

# vconsole
sudo rm -f /etc/vconsole.conf

# dunst
mkdir -p ~/.config/dunst
sudo mv config/dunst/dunstrc ~/.config/dunst


# rebuild openbox menu
mmaker -v OpenBox3


# Done

sudo reboot
