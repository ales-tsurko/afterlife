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

# node.js, yarn
sudo pacman -S --noconfirm nodejs yarn

# cli tools, other

# bat - cat with syntax highliting
# fzf - fuzzy finder
# ripgrep - modern grep replacement
# tree - directory listing
# bandwhich - display network utilization
sudo pacman -S --noconfirm bat cmake fzf ripgrep tree bandwhich

# mcfly - better ctrl-r
# ytop-bin - better top
# tealdeer-bin - man pages briefly, tldr replacement
yay -S --noconfirm mcfly ytop-bin tealdeer-bin

# navi - terminal cheatsheets
# starship - command prompt
# procs - modern ps replacement
cargo install navi starship procs

echo "\n\n\n!!!read docs to finish starship installation: https://starship.rs/\n\n\n"
