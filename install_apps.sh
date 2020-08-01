#!/bin/bash

# telegram - messenger
# brave - web browser
# thunar - file browser
# nomacs - image viewer
sudo pacman -S --noconfirm telegram-desktop brave-beta thunar \
	thunar-archive-plugin nomacs

# Development

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
